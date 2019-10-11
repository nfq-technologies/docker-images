#!/bin/bash

set -x
set -e

echo force-unsafe-io > /etc/dpkg/dpkg.cfg.d/02apt-speedup

apt-get update
apt-get upgrade -y


# install standard tools
apt-get install -y --no-install-recommends \
	bash-completion \
	bzip2 dnsutils \
	less \
	netcat-traditional \
	patch \
	time \
	traceroute \
	w3m \
	curl \
	wget \
	whiptail \
	whois \
	telnet \
	net-tools \


# install various helper tools
apt-get install -y --no-install-recommends \
	vim \
	nano \
	nethogs \
	pv \
	git \
	rsync \
	iotop \
	sysstat \
	ngrep \
	mc \
	sudo \
	locales \
	man \
	apt-transport-https \
	unzip \
	strace \


# install acl to support advanced file permissions
apt-get install -y --no-install-recommends acl

# install ssh client
apt-get install -y --no-install-recommends openssh-client

# configure user project
useradd -d /home/project -m -s /bin/bash -u 1000 -U project
echo 'project:project' | chpasswd
echo 'project ALL=NOPASSWD: ALL' >> /etc/sudoers


apt-get install -y --no-install-recommends cowsay
ln -s /usr/games/cowsay /usr/local/bin/

# Generate locales
locale-gen "en_US.UTF-8"
dpkg-reconfigure locales
echo LC_ALL=en_US.UTF-8 > /etc/default/locale

cp -frv /build/files/* / || true


source /usr/local/build_scripts/cleanup_apt.sh

