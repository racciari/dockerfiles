FROM ubuntu:16.04
MAINTAINER "Romain Acciari" <romain.acciari@openio.io>

RUN apt-get update \
    && apt -y install debootstrap qemu-user-static qemu-system-aarch64 qemu-user-static linux-libc-dev-arm64-cross libc6-arm64-cross

VOLUME ["/mnt"]

ADD debootstrap.sh /

ENTRYPOINT ["/debootstrap.sh"]
#docker run --privileged -v /mnt/:/mnt/ --net=host -ti --tty ubuntu:16.04 /bin/bash
