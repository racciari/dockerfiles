log 'Setting interface configuration'
cat <<EOF >>etc/network/interfaces.d/eth0
allow-hotplug eth0
iface eth0 inet dhcp
EOF
cat <<EOF >>etc/network/interfaces.d/eth1
allow-hotplug eth1
iface eth1 inet dhcp
EOF
