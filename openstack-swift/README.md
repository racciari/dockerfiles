# openstack-swift

This image provides an easy way to run the [Openstack Swift](https://docs.openstack.org/developer/swift/) command.  

## How to use this image

Just run the container with your endpoint and credentials as parameters:  

```console
# docker run openstack-swift -A http://192.168.56.101:6007/auth/v1.0/ -U demo:demo -K DEMO_PASS list
```

More informations about the [Openstack Swift command line](https://docs.openstack.org/cli-reference/swift.html) parameters in the documentation.
