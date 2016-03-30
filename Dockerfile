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
       vim git  libboost-dev  gdb

# Cmake
RUN curl -sc 0 https://cmake.org/files/v3.2/cmake-3.2.2-Linux-x86_64.tar.gz | tar -xz -C /usr/local  \
	&& cd /usr/local \
    && ln -s ./cmake-3.2.2-Linux-x86_64 cmake
ENV PATH $PATH:/usr/local/cmake/bin

ENV TBB_VERSION 43_20150611
ENV TBB_DOWNLOAD_URL https://www.threadingbuildingblocks.org/sites/default/files/software_releases/linux/tbb${TBB_VERSION}oss_lin.tgz
ENV TBB_INSTALL_DIR /opt

RUN wget ${TBB_DOWNLOAD_URL} \
    && tar -C ${TBB_INSTALL_DIR} -xf tbb${TBB_VERSION}oss_lin.tgz \
    && rm tbb${TBB_VERSION}oss_lin.tgz

RUN sed -i "s%SUBSTITUTE_INSTALL_DIR_HERE%${TBB_INSTALL_DIR}/tbb${TBB_VERSION}oss%" ${TBB_INSTALL_DIR}/tbb${TBB_VERSION}oss/bin/tbbvars.*

RUN echo "source ${TBB_INSTALL_DIR}/tbb${TBB_VERSION}oss/bin/tbbvars.sh intel64" >> /etc/bash.bashrc

CMD ["/bin/bash"]

