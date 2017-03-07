#!/bin/sh

if [ -z "$AWS_ACCESS_KEY_ID" -a -z "$AWS_SECRET_ACCESS_KEY" ]; then
  echo 'AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY environment variables are not specified.'
  exit 1
fi

sed -i -e "s@AWS_ACCESS_KEY_ID@$AWS_ACCESS_KEY_ID@g" \
       -e "s@AWS_SECRET_ACCESS_KEY@$AWS_SECRET_ACCESS_KEY@g" \
  ~/.aws/credentials

/usr/bin/aws "$@"
