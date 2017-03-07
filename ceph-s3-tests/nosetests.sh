#!/bin/sh
set -e

source s3-tests/virtualenv/bin/activate \
  && S3TEST_CONF=/config s3-tests/virtualenv/bin/nosetests "$@"
