# openstack-client

This image provides an easy way to run the [Openstack client](https://docs.openstack.org/python-openstackclient/latest/) command.  

## How to use this image

Just run the container with your endpoint and credentials as parameters:  

```console
# docker run -e OS_IDENTITY_API_VERSION="3" -e OS_AUTH_URL="http://192.168.56.102:5000" -e OS_USER_DOMAIN_ID="default" -e OS_PROJECT_DOMAIN_ID="default" -e OS_PROJECT_NAME="admin" -e OS_USERNAME="admin" -e OS_PASSWORD="ADMIN_PASS" racciari/openstack-client
```

More informations about the [Openstack Swift command line](https://docs.openstack.org/cli-reference/swift.html) parameters in the documentation.
