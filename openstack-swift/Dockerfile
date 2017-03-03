FROM alpine
RUN apk add --no-cache bash py2-pip gcc python2-dev linux-headers libc-dev \
      && pip install python-swiftclient
ENTRYPOINT ["/bin/bash"]
