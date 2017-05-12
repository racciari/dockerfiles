#!/bin/bash
set -e


function log() {
  echo "> $*"
}

function showlog() {
  if [ -r ubuntu/debootstrap/debootstrap.log ]; then
    log 'Showing debootstrap log'
    tail -n20 ubuntu/debootstrap/debootstrap.log
  fi
}

function cleanup() {
  showlog
  log "Unmounting loop device: $lodev"
  umount ubuntu || true
  rmdir ubuntu || true
  losetup -d $lodev
}

# Cleanup before exit
trap cleanup EXIT

variant=${VARIANT:-minbase}
packages=${PACKAGES:-vim-tiny,iputils-ping,iproute2,openssh-server,ethtool,ifupdown,isc-dhcp-client,net-tools,xfsprogs,sudo,curl,udev}
arch=${ARCH:-arm64}
codename=${CODENAME:-xenial}
dist=${DIST:-ubuntu}
repo=${REPOSITORY:-http://ports.ubuntu.com/ubuntu-ports/}
hostname=${IMGHOSTNAME:-armadabox}
imgsize=${IMGSIZE:-300}

log "Build $dist $codename image for $arch architecture"

pushd /mnt

log "Creating image: $imgsize MB"
dd if=/dev/zero of=ubuntu.img bs=1M count=$imgsize
mkfs.ext4 ubuntu.img
mkdir ubuntu

# Create loop device
lodev=$(losetup -f)
if [ ! -e $lodev ]; then
  mknod $lodev b 7 ${lodev//\/dev\/loop}
fi
log "Mounting loop device: $lodev"
losetup $lodev ubuntu.img
mount $lodev ubuntu/

log 'Starting debootstrap first stage'
debootstrap --variant=$variant --include=$packages --arch=$arch --foreign $codename $dist $repo

# Setup binfmt for emulation
mount binfmt_misc -t binfmt_misc /proc/sys/fs/binfmt_misc
cp /usr/bin/qemu-*-static ubuntu/usr/bin/

log 'Starting debootstrap second stage'
DEBIAN_FRONTEND=noninteractive DEBCONF_NONINTERACTIVE_SEEN=true LC_ALL=C LANGUAGE=C LANG=C chroot ubuntu /debootstrap/debootstrap --second-stage
log 'Packages configuration'
DEBIAN_FRONTEND=noninteractive DEBCONF_NONINTERACTIVE_SEEN=true LC_ALL=C LANGUAGE=C LANG=C chroot ubuntu dpkg --configure -a

log 'Performing configuration modifications'
sed -i -e 's@^BindsTo=dev-%i.device@#BindsTo=dev-%i.device@' ubuntu/lib/systemd/system/serial-getty@.service
sed -i -e 's@root:\*@root:@' ubuntu/etc/shadow
echo ttyMV0 >>ubuntu/etc/securetty
echo $hostname >ubuntu/etc/hostname

log 'Stripping down files'
cat <<EOF >>ubuntu/etc/dpkg/dpkg.cfg.d/01_nodoc
path-exclude /usr/share/doc/*
# we need to keep copyright files for legal reasons
path-include /usr/share/doc/*/copyright
path-exclude /usr/share/man/*
path-exclude /usr/share/groff/*
path-exclude /usr/share/info/*
# lintian stuff is small, but really unnecessary
path-exclude /usr/share/lintian/*
path-exclude /usr/share/linda/*
path-exclude /usr/share/locale/*
path-include /usr/share/locale/en*
EOF
find ubuntu/usr/share/doc -depth -type f ! -name copyright|xargs rm || true
find ubuntu/usr/share/doc -empty|xargs rmdir || true
find ubuntu/usr/share/man ubuntu/usr/share/groff ubuntu/usr/share/info ubuntu/usr/share/lintian ubuntu/usr/share/linda ubuntu/var/cache/man -type f|xargs rm || true
find ubuntu/usr/share/locale -mindepth 1 -maxdepth 1 ! -name 'en' |xargs rm -r
cat <<EOF >>ubuntu/etc/apt/apt.conf.d/02compress-indexes
Acquire::GzipIndexes "true";
Acquire::CompressionTypes::Order:: "gz";
EOF
cat <<EOF >>ubuntu/etc/apt/apt.conf.d/02nocache
Dir::Cache {
   srcpkgcache "";
   pkgcache "";
}
EOF
rm -f ubuntu/var/cache/apt/*.bin

log 'Removing qemu files'
rm -f ubuntu/usr/bin/qemu-*-static

log 'Finished successfully'

popd
