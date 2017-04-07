FROM alpine:3.5
MAINTAINER "Romain Acciari" <romain.acciari@openio.io>

RUN apk --no-cache add dnsmasq

EXPOSE 53 53/udp
VOLUME ["/etc/dnsmasq.d"]

ENTRYPOINT ["/usr/sbin/dnsmasq", "-k", "-d"]
