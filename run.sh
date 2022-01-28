#!/bin/bash
GITNAME="GNAME=$1"
GITEMAIL="GEMAIL=$2"
DOTSSH="$3:/mnt/.ssh:ro" \
      echo \
      docker container run -d \
      -p 55111:55111 \
      -p 60001:60001/udp \
      -v $DOTSSH \
      -e $GITNAME \
      -e $GITEMAIL \
      devenv:latest
