# openstack-swift

This image provides an easy way to run the [Openstack Swift](https://docs.openstack.org/developer/swift/) command.  

## How to use this image

Using the basic authentification API v1, just run the container with your endpoint and credentials as parameters:  

```console
# docker run racciari/openstack-swift -A http://192.168.56.101:6007/auth/v1.0/ -U demo:demo -K DEMO_PASS list
```

When using Openstack Identity API v2 or v3, you can use environment variables:  

```console
# docker run -ti -e OS_IDENTITY_API_VERSION="3" -e OS_AUTH_URL="http://192.168.56.102:5000" -e OS_USER_DOMAIN_ID="default" -e OS_PROJECT_DOMAIN_ID="default" -e OS_PROJECT_NAME="demo" -e OS_USERNAME="demo" -e OS_PASSWORD="DEMO_PASS" openstack-swift list
```

More informations about the [Openstack Swift command line](https://docs.openstack.org/cli-reference/swift.html) parameters in the documentation.
