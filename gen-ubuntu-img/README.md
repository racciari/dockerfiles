# gen-ubuntu-img

This image provides an easy way to create a custom Ubuntu image for another architecture.

## How to use this image

By default, this image creates a custom Ubuntu 16.04 Xenial image for arm64 architecture, designed to optimize space usage.  
It requires special priviliges to mount loop devices.
The image is generated in the */mnt* directory you can mount on your host:

```console
# docker run --privileged -v /mnt/:/mnt/ racciari/gen-ubuntu-img
```

