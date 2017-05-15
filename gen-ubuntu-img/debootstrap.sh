#!/bin/bash
set -e


function log() {
  echo "> $*"
}

function showlog() {
  if [ -r $wrkdir/$chrootdir/debootstrap/debootstrap.log ]; then
    log 'Showing debootstrap log'
    tail -n20 $wrkdir/$chrootdir/debootstrap/debootstrap.log
  fi
}

function cleanup() {
  showlog
  log "Unmounting loop device: $lodev"
  umount $wrkdir/$chrootdir || true
  rmdir $wrkdir/$chrootdir || true
  losetup -d $lodev || true
}

# Cleanup before exit
trap cleanup EXIT

variant=${VARIANT:-minbase}
packages=${PACKAGES:-vim-tiny,iputils-ping,iproute2,openssh-server,ethtool,ifupdown,isc-dhcp-client,net-tools,xfsprogs,sudo,curl,udev,python}
arch=${ARCH:-arm64}
codename=${CODENAME:-xenial}
dist=${DIST:-ubuntu}
repo=${REPOSITORY:-http://ports.ubuntu.com/ubuntu-ports/}
hostname=${IMGHOSTNAME:-armadabox}
imgname=${IMGNAME:-ubuntu.img}
imgsize=${IMGSIZE:-250}
wrkdir=${WRKDIR:-/mnt}
chrootdir=${CHROOTDIR:-ubuntu}

qemuarch=$arch
case $arch in
  'arm64')
    qemuarch='aarch64'
    ;;
esac

log "Build $dist $codename image for $arch architecture"

pushd $wrkdir

log "Creating image: $imgsize MB"
dd if=/dev/zero of=$imgname bs=1M count=$imgsize
mkfs.ext4 $imgname
mkdir $chrootdir

# Create loop device
lodev=$(losetup -f)
if [ ! -e $lodev ]; then
  mknod $lodev b 7 ${lodev//\/dev\/loop}
fi
log "Mounting loop device: $lodev"
losetup $lodev $imgname
mount $lodev $chrootdir/

log 'Starting debootstrap first stage'
debootstrap --variant=$variant --include=$packages --arch=$arch --foreign $codename $dist $repo

# Setup binfmt for emulation
mount binfmt_misc -t binfmt_misc /proc/sys/fs/binfmt_misc
cp /usr/bin/qemu-${qemuarch}-static $chrootdir/usr/bin/
update-binfmts --enable qemu-$qemuarch

log 'Starting debootstrap second stage'
DEBIAN_FRONTEND=noninteractive DEBCONF_NONINTERACTIVE_SEEN=true LC_ALL=C LANGUAGE=C LANG=C chroot $chrootdir /debootstrap/debootstrap --second-stage

log 'Packages configuration'
DEBIAN_FRONTEND=noninteractive DEBCONF_NONINTERACTIVE_SEEN=true LC_ALL=C LANGUAGE=C LANG=C chroot $chrootdir dpkg --configure -a

log 'Performing image modifications in $chrootdir directory'
pushd $chrootdir
for file in /scripts/*
do
  source $file
done

log 'Removing qemu files'
rm -f usr/bin/qemu-*-static
popd

log 'Image creation finished successfully'

popd
