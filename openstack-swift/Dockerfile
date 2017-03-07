FROM alpine
MAINTAINER "Romain Acciari" <romain.acciari@openio.io>

RUN apk add --no-cache bash py2-pip gcc python2-dev linux-headers libc-dev \
      && pip install python-swiftclient

ENTRYPOINT ["/usr/bin/swift"]
