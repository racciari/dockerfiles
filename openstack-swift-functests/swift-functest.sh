#!/bin/bash

if [ ! -z "$SWIFT_HOST" ]; then
  sed -i -e "s@^auth_host =.*@auth_host = ${SWIFT_HOST}@" /etc/swift/test.conf
fi

if [ ! -z "$SWIFT_PORT" ]; then
  sed -i -e "s@^auth_port =.*@auth_port = ${SWIFT_PORT}@" /etc/swift/test.conf
fi

if [ ! -z "$AUTH_PREFIX" ]; then
  sed -i -e "s@^auth_prefix =.*@auth_prefix = ${AUTH_PREFIX}@" /etc/swift/test.conf
fi

if [ ! -z "$AUTH_VERSION" ]; then
  sed -i -e "s@^#auth_version =.*@auth_version = ${AUTH_VERSION}@" /etc/swift/test.conf
fi

if [ ! -z "$SWIFT_SSL" ]; then
  sed -i -e "s@^auth_ssl =.*@auth_ssl = ${SWIFT_SSL}@" /etc/swift/test.conf
fi

/swift/swift/.functests
