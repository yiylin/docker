# Creates git g++-4.8 gcc cmake 3.2.2 
#
# docker build -t lyysdy/ubuntu .

FROM ubuntu:14.04
MAINTAINER lyysdy@foxmail.com

USER root

# install dev tools
RUN apt-get update \
    && apt-get install -qqy curl tar g++-4.8 gcc \
	   libtool pkg-config autoconf openssh-server openssh-client rsync build-essential automake \
       vim git

# Cmake
RUN curl -sc 0 https://cmake.org/files/v3.2/cmake-3.2.2-Linux-x86_64.tar.gz | tar -xz -C /usr/local  \
	&& cd /usr/local \
    && ln -s ./cmake-3.2.2-Linux-x86_64 cmake
ENV PATH $PATH:/usr/local/cmake/bin

CMD ["/bin/bash"]

