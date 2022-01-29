#!/bin/bash
DOTSSH="/home/$USER/.ssh:/mnt/.ssh:ro" 
SRCHOME="/home/$USER/.dv/src:/src"
VIRTHOME="/home/$USER/.dv/virt:/home/$USER"

USERNAME="UNAME=$USER"
USERID="UID=$(id -u $USER)"
GROUPNAME="GNAME=$(id -gn $USER)"
USERGID="GID=$(id -g $USER)"

GITNAME="GNAME=$(git config user.name)"
GITEMAIL="GEMAIL=$(git config user.email)"

docker container run -d \
       -p 55111:55111 \
       -p 60001:60001/udp \
       -v $DOTSSH \
       -v $SRCHOME \
       -v $VIRTHOME \
       -e $GITNAME \
       -e $GITEMAIL \
       -e $USERNAME \
       -e $USERID \
       -e $GROUPNAME \
       -e $USERGID \
       devenv:latest
