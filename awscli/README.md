# awscli

This image provides an easy way to run the [AWS CLI](https://aws.amazon.com/cli/).  

## How to use this image

You need to set 2 environment variables at runtime:  
 * `AWS_ACCESS_KEY_ID`: your access key  
 * `AWS_SECRET_ACCESS_KEY`: your token  

You can also mount any directory to the /mnt directory inside the container to upload files.  

Then, you can just run the container:  

```console
# docker run -ti --tty -e AWS_ACCESS_KEY_ID=demo:demo -e AWS_SECRET_ACCESS_KEY=DEMO_PASS awscli --endpoint-url http://192.168.1.1:6007 --no-verify-ssl s3 ls
```

```console
# docker run -v ~/tmp:/mnt -ti --tty -e AWS_ACCESS_KEY_ID=demo:demo -e AWS_SECRET_ACCESS_KEY=DEMO_PASS awscli --endpoint-url http://192.168.1.1:6007 --no-verify-ssl s3 cp /mnt/file s3://bucket
```

More information on the AWS CLI in the [AWS CLI documentation](http://docs.aws.amazon.com/cli/latest/userguide/cli-chap-welcome.html).
