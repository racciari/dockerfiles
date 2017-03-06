FROM centos:latest
MAINTAINER "Romain Acciari" <romain.acciari@openio.io>

RUN yum -y install python-virtualenv git sudo \
  && git clone https://github.com/ceph/s3-tests.git \
  && cd s3-tests \
  && ./bootstrap

ADD nosetests.sh config /

ENTRYPOINT ["/nosetests.sh"]
