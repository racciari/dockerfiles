#!/bin/sh
set -e

# Configuration
if [ ! -z "$S3_HOST" ]; then
  echo "Setting S3 host to $S3_HOST"
  sed -i -e "s@^host =.*@host = $S3_HOST@g" \
    /config
fi
if [ ! -z "$S3_PORT" ]; then
  echo "Setting S3 port to $S3_PORT"
  sed -i -e "s@^port =.*@host = $S3_PORT@g" \
    /config
fi

# Start tests
echo 'Starting s3-tests ...'
source s3-tests/virtualenv/bin/activate \
  && S3TEST_CONF=/config s3-tests/virtualenv/bin/nosetests "$@"
