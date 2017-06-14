FROM nvidia/cuda:8.0-devel-ubuntu16.04

MAINTAINER Ewan Barr "ebarr@mpifr-bonn.mpg.de"

# Suppress debconf warnings
ENV DEBIAN_FRONTEND noninteractive

RUN echo "root:root" | chpasswd && \
    mkdir -p /root/.ssh

# Create psr user which will be used to run commands with reduced privileges.
RUN adduser --disabled-password --gecos 'unprivileged user' psr && \
    echo "psr:psr" | chpasswd && \
    mkdir -p /home/psr/.ssh && \
    chown -R psr:psr /home/psr/.ssh

# Create space for ssh daemon and update the system
RUN echo 'deb http://us.archive.ubuntu.com/ubuntu trusty main multiverse' >> /etc/apt/sources.list && \
    mkdir /var/run/sshd && \
    apt-get -y check && \
    apt-get -y update && \
    apt-get install -y apt-utils apt-transport-https software-properties-common python-software-properties && \
    apt-get -y update --fix-missing && \
    apt-get -y upgrade

RUN apt-get install -y --no-install-recommends git

ENV HOME /home/psr

RUN cd $HOME && \
    git clone https://github.com/ewanbarr/dedisp.git && \
    git clone https://github.com/ewanbarr/peasoup.git

WORKDIR $HOME/dedisp

COPY dedisp_files/* $HOME/dedisp/

RUN make -j 

ENV LD_LIBRARY_PATH /home/psr/dedisp/lib

WORKDIR $HOME/peasoup

COPY peasoup_files/* $HOME/peasoup/

RUN make -j

ENV PATH ${PATH}:/home/psr/peasoup/bin

