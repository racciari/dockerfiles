# ceph-s3-tests

This image provides an easy way to run S3 compatibility tests from the [Ceph project](http://ceph.com).

## How to use this image

You need to customize the config file to point the host to your S3 endpoint and
change the credentials of both accounts *main* and *alt*.  

Then, you can just run the container:

```console
# docker run ceph-s3-tests
```

Like described in the [Ceph S3 tests GitHub page](https://github.com/ceph/s3-tests), 
you can add parameters to the container:

```console
# docker run ceph-s3-tests -v --collect-only
# docker run ceph-s3-tests s3tests.functional.test_s3:test_bucket_list_empty
```
