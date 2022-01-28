FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
      openssh-server \
      mosh \
      bash \
      git \
      vim-tiny \
      sbcl \
      clang \
      python3 \
      ca-certificates \
      locales \
      dos2unix \
      emacs

COPY build/sshd_config /etc/ssh/sshd_config

RUN service ssh start
RUN service ssh stop

RUN sed -i '/en_US.UTF-8/s/^# //g' /etc/locale.gen && \
    locale-gen
#RUN echo "LC_ALL=en_US.UTF-8" >> /etc/environment && \
#    echo "LANG=en_US.UTF-8" >> /etc/environment
ENV LANG en_US.UTF-8  
ENV LANGUAGE en_US:en  
ENV LC_ALL en_US.UTF-8

EXPOSE 55111 60001/udp

COPY build/start.sh /usr/local/bin/start.sh
RUN dos2unix /usr/local/bin/start.sh

ENTRYPOINT ["bash", "/usr/local/bin/start.sh"]
