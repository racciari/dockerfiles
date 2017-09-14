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

HTTP_TYPE="http"
if [ ! -z "$SWIFT_SSL" ]; then
  sed -i -e "s@^auth_ssl =.*@auth_ssl = ${SWIFT_SSL}@" /etc/swift/test.conf
  HTTP_TYPE="https"
fi

# Wait for the swift gateway to be reachable
TIMEOUT=120
echo "Waiting for swift gateway to be ready..."
etime_start=$(date +"%s")
etime_end=$(($etime_start + $TIMEOUT))
swift=42
while [ $(date +"%s") -le $etime_end -a $swift -ne 0 ]
do
  echo "Trying to connect to swift gateway: $HTTP_TYPE://$SWIFT_HOST:$SWIFT_PORT/auth/v1.0"
  timeout 5 swift -A "$HTTP_TYPE://$SWIFT_HOST:$SWIFT_PORT/auth/v1.0" -U admin:admin -K admin stat >/dev/null 2>&1
  swift=$?
done
if [ $swift -ne 0 ]; then
  echo "Cannot reach swift gateway: $swift"
  exit 1
fi

# Wait for the swift gateway to be usable
TIMEOUT=120
echo "Waiting for swift gateway to be usable..."
etime_start=$(date +"%s")
etime_end=$(($etime_start + $TIMEOUT))
swift=42
while [ $(date +"%s") -le $etime_end -a $swift -ne 0 ]
do
  echo "Trying to create a container"
  timeout 5 swift -A "$HTTP_TYPE://$SWIFT_HOST:$SWIFT_PORT/auth/v1.0" -U admin:admin -K admin post testcont >/dev/null 2>&1
  swift=$?
done
if [ $swift -ne 0 ]; then
  echo "Cannot create container: $swift"
  exit 1
fi

# Cleanup the test container
swift -A "$HTTP_TYPE://$SWIFT_HOST:$SWIFT_PORT/auth/v1.0" -U admin:admin -K admin delete testcont >/dev/null 2>&1
if [ $? -ne 0 ]; then
  echo "Cannot delete container"
  exit 1
fi

echo 'The swift gateway is ready, launching tests...'

/swift/swift/.functests
