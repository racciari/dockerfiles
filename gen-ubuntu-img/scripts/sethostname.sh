if [ -z "$hostname" ]; then
  log "Set empty hostname"
else
  log "Set hostname to $hostname"
fi
echo "$hostname" >etc/hostname
