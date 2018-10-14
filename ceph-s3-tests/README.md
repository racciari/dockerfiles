# ceph-s3-tests

This image provides an easy way to run [S3 compatibility tests](https://github.com/ceph/s3-tests) from the [Ceph project](http://ceph.com).

## How to use this image

The testsuite uses 2 S3 accounts, a main one and an alt one. You need to either have default accounts setup on your platform or provide 2 accounts through the command line.  
The default credentials used to run tests are available in the `config` [file](https://github.com/racciari/dockerfiles/blob/master/ceph-s3-tests/config).  It uses 2 accounts, default setup works with default accounts for the Openstack Swift functional tests.  

You need to specify the environment variables `S3_HOST` and `S3_PORT` to fit your setup.  

```console
# docker run -e S3_HOST="192.168.56.102" -e S3_PORT=6007 -e S3_MAIN_ACCESS_KEY="161c1f60bb8d487abe5cc05a62dc1a03" -e S3_MAIN_SECRET_KEY="56ebdf2e8c3640e6bdd70afef12dfdb1" -e S3_ALT_ACCESS_KEY="96e2dbbfb08e448b8b9d1cd9b73489de" -e S3_ALT_SECRET_KEY="6fda5178ddf34f3f9e3fee3883cf47d6" racciari/ceph-s3-tests
```

Like described in the [Ceph S3 tests GitHub page](https://github.com/ceph/s3-tests), you can add parameters to the container:  

```console
# docker run racciari/ceph-s3-tests -v --collect-only  
# docker run racciari/ceph-s3-tests s3tests.functional.test_s3:test_bucket_list_empty
```
