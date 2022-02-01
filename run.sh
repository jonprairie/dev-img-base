#!/bin/bash
DOTSSH="/home/$USER/.ssh:/mnt/.ssh:ro" 
SRCHOME="/home/$USER/.dv/src:/src"
VIRTHOME="/home/$USER/.dv/virt:/home/$USER"

USERNAME="UNAME=$USER"
USERID="UID=$(id -u $USER)"
GROUPNAME="GRPNAME=$(id -gn $USER)"
USERGID="GRPID=$(id -g $USER)"

GITNAME="GITNAME=$(git config user.name)"
GITEMAIL="GITEMAIL=$(git config user.email)"

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
       dev-img-base:latest
