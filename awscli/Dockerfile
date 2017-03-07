FROM alpine:edge
MAINTAINER "Romain Acciari" <romain.acciari@openio.io>

ADD repositories /etc/apk/
ADD awsrequest.patch aws.sh /

RUN apk add --no-cache awscli
RUN cd /usr/lib/python3.6/site-packages \
    && patch -p1 -i /awsrequest.patch \
    && mkdir -p /root/.aws

ADD config credentials /root/.aws/

VOLUME ["/mnt"]

ENTRYPOINT ["/aws.sh"]
