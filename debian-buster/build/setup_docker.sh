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
	telnet \
	time \
	traceroute \
	w3m \
	curl \
	wget \
	whiptail \
	whois \
	procps \
	net-tools \
	zip \


# install various helper tools
apt-get install -y --no-install-recommends \
	vim \
	nethogs \
	pv \
	gettext \
	git \
	rsync \
	iotop \
	sysstat \
	ngrep \
	mc \
	ca-certificates \
	sudo \
	locales \
	man \
	moreutils \
	apt-transport-https \
	gnupg \
	unzip \
	strace \
	jq \
	shellcheck \
	gnupg \
	dirmngr \
	socat \


# install acl to support advanced file permissions
apt-get install -y --no-install-recommends acl

# install ssh client
apt-get install -y --no-install-recommends openssh-client

# configure user project
useradd -d /home/project -m -s /bin/bash -u 1000 -U project
echo 'project:project' | chpasswd
echo 'project ALL=NOPASSWD: ALL' >> /etc/sudoers

# add debian-repo.nfq.lt key
apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 5791B856FE7BB48D

apt-get install -y --no-install-recommends cowsay
ln -s /usr/games/cowsay /usr/local/bin/

# Generate locales
echo en_US.UTF-8 UTF-8 > /etc/locale.gen
dpkg-reconfigure locales
echo LC_ALL=en_US.UTF-8 > /etc/default/locale


# vim plugins
cd /tmp
wget -qO- https://github.com/w0rp/ale/archive/v1.7.0.tar.gz | tar xz
mkdir -p /home/project/.vim/pack/git-plugins/start
mv ale-1.7.0 /home/project/.vim/pack/git-plugins/start/ale
chown -R project:project /home/project/.vim

# Fix vim mouse integration
sed -ri 's/^([ ]*set mouse=a)/"\1/' /usr/share/vim/vim81/defaults.vim

cp -frv /build/files/* /


source /usr/local/build_scripts/cleanup_apt.sh

