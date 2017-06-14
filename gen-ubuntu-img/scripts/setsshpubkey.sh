sshuser='root'
if [ "$sshuser" == 'root' ]; then
  homedir='root'
  useradd=false
else
  home='home/$sshuser'
  useradd=true
fi
if [ -r "$sshpubkeyfile" ]; then
  sshpubkey=$(cat "$sshpubkeyfile")
fi

if [ "$useradd" == 'true' ]; then
  log 'Creating $sshuser home directory'
  useradd -m -U -d $homedir $sshuser
fi

if [ ! -z "$sshpubkey" ]; then
  log 'Set SSH public key to user $sshuser'
  mkdir -p $homedir/.ssh
  echo $sshpubkey >$homedir/.ssh/authorized_keys
  chmod 700 $homedir/.ssh
  chmod 400 $homedir/.ssh/authorized_keys
fi
