FROM ubuntu:16.10
MAINTAINER "Romain Acciari" <romain.acciari@openio.io>

RUN apt-get update \
    && apt-get -y install git python-setuptools python-eventlet \
         python-netifaces python-mock python-pyeclib python-swiftclient \
         python-pastedeploy python-xattr python-nose python-os-testr
RUN mkdir -p /swift /etc/swift \
    && cd /swift \
    && git clone https://github.com/openstack/swift.git \
    && cp swift/test/sample.conf /etc/swift/test.conf

ADD swift-functest.sh /

CMD ["/swift-functest.sh"]