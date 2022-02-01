echo "${UNAME}:x:${UID}:${GRPID}:${UNAME},,,:/home/${UNAME}:${SHELL}" >> /etc/passwd \
    && echo "${UNAME}::17032:0:99999:7:::">> /etc/shadow \
    && echo "${UNAME} ALL=(ALL) NOPASSWD: ALL"> "/etc/sudoers.d/${UNAME}" \
    && chmod 0440 "/etc/sudoers.d/${UNAME}" \
    && echo "${GRPNAME}:x:${GRPID}:${UNAME}" >> /etc/group

UHOME="/home/$UNAME"
if [[ -d "$UHOME/.ssh" ]]; then
    echo ".ssh already exists. skipping key copy."
else
    echo ".ssh does not exist. copying keys."
    mkdir -p "$UHOME/.ssh" && chmod 0700 "$UHOME/.ssh"

    cp /mnt/.ssh/id_rsa "$UHOME/.ssh/id_rsa"
    chmod 0600 "$UHOME/.ssh/id_rsa"

    cp /mnt/.ssh/id_rsa.pub "$UHOME/.ssh/id_rsa.pub"
    chmod 0600 "$UHOME/.ssh/id_rsa.pub"

    cp /mnt/.ssh/id_rsa.pub "$UHOME/.ssh/authorized_keys"
    chmod 0600 "$UHOME/.ssh/authorized_keys"

    if [[ -e "/mnt/.ssh/authorized_keys" ]]; then
        cat /mnt/.ssh/authorized_keys >> $UHOME/.ssh/authorized_keys
    fi

    chown -hR "$UNAME:$GRPNAME" "$UHOME"

    ssh-keyscan github.com >> "$UHOME/.ssh/known_hosts"
    ssh-keyscan gitlab.com >> "$UHOME/.ssh/known_hosts"
    ssh-keyscan bitbucket.com >> "$UHOME/.ssh/known_hosts"
fi

#!/bin/bash

git config --global user.email $GITEMAIL
git config --global user.name $GITNAME

mosh-server 
/usr/sbin/sshd -De
