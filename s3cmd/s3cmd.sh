#!/bin/bash
#set -ex

#ACCESS_KEY
#SECRET_KEY
: ${BUCKET_LOCATION:=US}
: ${HOST_BASE:=s3.amazonaws.com}
: ${HOST_BUCKET:=%(bucket)s.s3.amazonaws.com}
: ${SIGNATURE_V2:=False}

sed -i -e "s@ACCESS_KEY@$ACCESS_KEY@g" \
       -e "s@SECRET_KEY@$SECRET_KEY@g" \
       -e "s@BUCKET_LOCATION@$BUCKET_LOCATION@g" \
       -e "s@HOST_BASE@$HOST_BASE@g" \
       -e "s@HOST_BUCKET@$HOST_BUCKET@g" \
       -e "s@SIGNATURE_V2@$SIGNATURE_V2@g" \
  /root/.s3cfg

/usr/bin/s3cmd "$@"
