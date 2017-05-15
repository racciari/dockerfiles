log 'Stripping down files'
cat <<EOF >>etc/dpkg/dpkg.cfg.d/01_nodoc
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
find usr/share/doc -depth -type f ! -name copyright|xargs rm || true
find usr/share/doc -empty|xargs rmdir || true
find usr/share/man usr/share/groff usr/share/info usr/share/lintian usr/share/linda var/cache/man -type f|xargs rm || true
find usr/share/man usr/share/groff usr/share/info usr/share/lintian usr/share/linda var/cache/man -type l|xargs rm || true
find usr/share/locale -mindepth 1 -maxdepth 1 ! -name 'en' |xargs rm -r
cat <<EOF >>etc/apt/apt.conf.d/02compress-indexes
Acquire::GzipIndexes "true";
Acquire::CompressionTypes::Order:: "gz";
EOF
cat <<EOF >>etc/apt/apt.conf.d/02nocache
Dir::Cache {
   srcpkgcache "";
   pkgcache "";
}
EOF
