#!/bin/bash

set -x
set -e

arch="$([ "`uname -m`" = "aarch64" ] && echo "arm64" || echo "amd64")"
arch_aws="$([ "`uname -m`" = "aarch64" ] && echo "aarch64" || echo "x86_64")"

echo force-unsafe-io > /etc/dpkg/dpkg.cfg.d/02apt-speedup

apt update

# Install Docker CE CLI from official Docker repo (API 1.44+)
apt-get install -y --no-install-recommends ca-certificates curl
install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
chmod a+r /etc/apt/keyrings/docker.asc
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian bullseye stable" > /etc/apt/sources.list.d/docker.list
apt-get update
apt-get install -y --no-install-recommends docker-ce-cli docker-compose-plugin

# Add compatibility symlink for old docker-compose calls
ln -s /usr/libexec/docker/cli-plugins/docker-compose /usr/local/bin/docker-compose

apt install -y --no-install-recommends -y make \
	bash-completion \
	bzip2 dnsutils \
	curl \
	iputils-ping \
	less \
	netcat-traditional \
	net-tools \
	patch \
	procps \
	telnet \
	time \
	traceroute \
	w3m \
	wget \
	whiptail \
	whois \
	zip


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
	iproute2 \


# install ssh client
apt-get install -y --no-install-recommends openssh-client

# Install awscli v2
curl "https://awscli.amazonaws.com/awscli-exe-linux-${arch_aws}.zip" -o "awscliv2.zip"
unzip awscliv2.zip
./aws/install
rm -rf awscliv2.zip ./aws

# configure user project
useradd -d /home/project -m -s /bin/bash -u 1000 -U project
echo 'project:project' | chpasswd
echo 'project ALL=NOPASSWD: ALL' >> /etc/sudoers

# Installing gojq ( used to replace phyaml )
wget ftp.lt.debian.org/debian/pool/main/g/gojq/gojq_0.12.11-1_$arch.deb -O ./gojq.deb
apt install ./gojq.deb
rm ./gojq.deb

# Fix vim mouse integration
sed -ri 's/^([ ]*set mouse=a)/"\1/' /usr/share/vim/vim82/defaults.vim

cp -frv /build/files/* /


source /usr/local/build_scripts/cleanup_apt.sh

