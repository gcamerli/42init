FROM debian:jessie
USER root

LABEL maintainer="https://gcamer.li"

# Add name to Docker image
ENV NAME=42init

# Set environment variables
ENV TERM=xterm
ENV DEBIAN_FRONTEND=noninteractive
ENV RUNLEVEL=1
RUN echo "deb http://deb.debian.org/debian jessie main contrib non-free" > /etc/apt/sources.list
RUN echo "deb http://deb.debian.org/debian jessie-updates main contrib non-free" >> /etc/apt/sources.list
RUN echo "deb http://security.debian.org jessie/updates main contrib non-free" >> /etc/apt/sources.list

# Update Debian
RUN apt update
RUN apt upgrade
RUN apt install -y \
  apt-utils \
  xterm \
  dialog \
  build-essential \
  autoconf \
  dh-autoreconf \
  automake \
  autogen \
  libtool \
  curl \
  wget \
  screen \
  libudev-dev \
  vim \
  git \
  openssh \
  zsh

# Clean apt lists
RUN rm -rf /var/lib/apt/lists/*

# Clone and set kerberos
RUN git clone --progress --verbose https://github.com/gcamerli/42krb.git kerberos
WORKDIR /root/kerberos/script
RUN sh run.sh
WORKDIR /root

# Set zsh as default shell
RUN sudo chsh -s /usr/bin/zsh root

# Set oh-my-zsh
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
