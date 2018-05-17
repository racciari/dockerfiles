FROM alpine
MAINTAINER "Romain Acciari" <romain.acciari@openio.io>

RUN apk add --no-cache \
      bash \
      py2-pip \
      gcc \
      python2-dev \
      linux-headers \
      libc-dev \
      libffi-dev \
      libressl-dev
RUN pip install --upgrade pip
RUN pip install pbr
RUN pip install python-swiftclient python-openstackclient

VOLUME ["/mnt"]

ENTRYPOINT ["/usr/bin/openstack"]
