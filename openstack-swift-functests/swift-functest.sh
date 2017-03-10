#!/bin/bash

if [ ! -z "$SWIFT_HOST" ]; then
  sed -i -e "s@^auth_host =.*@auth_host = ${SWIFT_HOST}@" /etc/swift/test.conf
fi

if [ ! -z "$SWIFT_PORT" ]; then
  sed -i -e "s@^auth_port =.*@auth_port = ${SWIFT_PORT}@" /etc/swift/test.conf
fi

if [ ! -z "$SWIFT_SSL" ]; then
  sed -i -e "s@^auth_ssl =.*@auth_ssl = ${SWIFT_SSL}@" /etc/swift/test.conf
fi

/swift/swift/.functests
