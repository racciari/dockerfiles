log 'Enable serial TTY'
sed -i -e 's@^BindsTo=dev-%i.device@#BindsTo=dev-%i.device@' lib/systemd/system/serial-getty@.service
