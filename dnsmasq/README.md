# dnsmasq

This image provides an easy way to run [dnsmasq](http://www.thekelleys.org.uk/dnsmasq/doc.html), the tiny DNS server.

## How to use this image

The default and empty configuration file is provided by default, you can add your configuration files using a volume mounted into `/etc/dnsmasq.d`.

```console
# docker run -d --net=host -v /path/to/dnsmasq.d:/etc/dnsmasq.d racciari/dnsmasq
```

To configure `dnsmasq`, please refer to the [documentation](http://www.thekelleys.org.uk/dnsmasq/docs/dnsmasq-man.html).
