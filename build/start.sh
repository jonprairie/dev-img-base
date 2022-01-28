#!/bin/bash

git config --global user.email $GEMAIL
git config --global user.name $GNAME

if [[ -d /root/.ssh ]]; then
   echo ".ssh already exists. skipping key copy."
else
   echo ".ssh does not exist. copying keys."
   mkdir -p /root/.ssh && chmod 0700 /root/.ssh
   cp /mnt/.ssh/id_rsa /root/.ssh/id_rsa
   cp /mnt/.ssh/id_rsa.pub /root/.ssh/id_rsa.pub
   cp /mnt/.ssh/id_rsa.pub /root/.ssh/authorized_keys
   chmod 0600 /root/.ssh/id_rsa
   chmod 0600 /root/.ssh/id_rsa.pub
   chmod 0600 /root/.ssh/authorized_keys
   ssh-keyscan github.com > /root/.ssh/known_hosts
fi

emacs --daemon
mosh-server 
/usr/sbin/sshd -De
