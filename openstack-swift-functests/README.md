# openstack-swift-functests

This image provides an easy way to run [Openstack Swift](https://github.com/openstack/swift) functional tests.

## How to use this image

Set the `SWIFT_HOST` and `SWIFT_PORT` to match your setup:

```console
# docker run -e SWIFT_HOST=192.168.56.101 -e SWIFT_PORT=6007 racciari/openstack-swift-functests
```

Your Openstack Swift server must have the [default credentials](https://github.com/openstack/swift/blob/master/test/sample.conf) configured.

