#!/bin/sh

# Defaults
: ${REGION:=us-east-1}

if [ -z "$AWS_ACCESS_KEY_ID" -a -z "$AWS_SECRET_ACCESS_KEY" ]; then
  echo 'AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY environment variables are not specified.'
  exit 1
fi

# Set credentials
sed -i -e "s@AWS_ACCESS_KEY_ID@$AWS_ACCESS_KEY_ID@g" \
       -e "s@AWS_SECRET_ACCESS_KEY@$AWS_SECRET_ACCESS_KEY@g" \
  ~/.aws/credentials

# Set config
if [ ! -z "$REGION" ]; then
  echo "region = $REGION" \
    >>~/.aws/config
fi
if [ ! -z "$SIGNATURE" ]; then
  echo "s3 =" \
    >>~/.aws/config
  echo "    signature_version = $SIGNATURE" \
    >>~/.aws/config
fi

/usr/bin/aws "$@"
