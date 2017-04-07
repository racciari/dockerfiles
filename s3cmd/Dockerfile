FROM centos:7
MAINTAINER "Romain Acciari" <romain.acciari@openio.io>

RUN yum -y install epel-release \
  && yum -y install s3cmd \
  && yum clean all

ADD s3cfg /root/.s3cfg
ADD s3cmd.sh /

ENTRYPOINT ["/s3cmd.sh"]
