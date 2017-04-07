# s3cmd

This image provides an easy way to run [s3cmd](http://s3tools.org/s3cmd) from [S3tools](http://s3tools.org).

## How to use this image

You need to provide credentials to access to your S3 resource, either by passing `--access_key` and `--secret_key` to the command line or using the `ACCESS_KEY` and `SECRET_KEY` environment variables.

Other environment variables are also available to configure `s3cmd`:
 - BUCKET_LOCATION (default: `US`)
 - HOST_BASE (default: `s3.amazonaws.com`)
 - HOST_BUCKET (default: `%(bucket)s.s3.amazonaws.com`)
 - SIGNATURE_V2 (default: `False`)

```console
# docker run -e ACCESS_KEY=demo:demo -e SECRET_KEY=DEMO_PASS -e BUCKET_LOCATION=US -e HOST_BASE=192.168.56.102:6007 -e HOST_BUCKET=%\(bucket\)s.test.openio.io:6007 -e SIGNATURE_V2=True racciari/s3cmd mb s3://bucket
```

More information on how to use `s3cmd` is available on the [s3tools documentation](http://s3tools.org/usage).
