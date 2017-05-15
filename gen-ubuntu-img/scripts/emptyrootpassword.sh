log 'Set root account passwordless'
sed -i -e 's@root:\*@root:@' /etc/shadow
