#!/bin/bash
GITNAME="GNAME=$1"
GITEMAIL="GEMAIL=$2"
DOTSSH="$3:/mnt/.ssh:ro" 
SRCHOME="$4:/src"
VIRTHOME="$5:/root"
docker container run -d \
       -p 55111:55111 \
       -p 60001:60001/udp \
       -v $DOTSSH \
       -v $SRCHOME \
       -v $VIRTHOME \
       -e $GITNAME \
       -e $GITEMAIL \
       devenv:latest
