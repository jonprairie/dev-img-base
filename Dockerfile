FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

ENV UID="1000" 
ENV UNAME="dev" 
ENV GRPID="1000" 
ENV GRPNAME="dev" 
ENV SHELL="/bin/bash"

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
      openssh-server \
      mosh \
      bash \
      sudo \
      git \
      vim-tiny \
      ca-certificates \
      locales \
      dos2unix

COPY build/sshd_config /etc/ssh/sshd_config

RUN service ssh start
RUN service ssh stop

RUN sed -i '/en_US.UTF-8/s/^# //g' /etc/locale.gen && \
    locale-gen
ENV LANG en_US.UTF-8  
ENV LANGUAGE en_US:en  
ENV LC_ALL en_US.UTF-8

EXPOSE 55111 60001/udp

COPY build/start.sh /usr/local/bin/start.sh
RUN dos2unix /usr/local/bin/start.sh

ENTRYPOINT ["bash", "/usr/local/bin/start.sh"]
