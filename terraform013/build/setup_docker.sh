#!/bin/bash

set -x
set -e

apt-get update

# Manulay downloading and install
file="$(wget -qO - https://releases.hashicorp.com/terraform/ \
	| sed 's/href="\/terraform\/\([^"]*\)\/">/\n\1\n/g' \
	| grep -i '^0\.13\.[0-9]\+$' \
	| sort --version-sort \
	| tail -n1)"

wget --no-check-certificate -O terraform.zip "https://releases.hashicorp.com/terraform/${file}/terraform_${file}_linux_amd64.zip"

unzip /terraform.zip -d /usr/local/bin/
rm terraform.zip
echo "AcceptEnv AWS_*" >> /etc/ssh/sshd_config

# Generate locales
locale-gen "en_US.UTF-8"
dpkg-reconfigure locales
echo LC_ALL=en_US.UTF-8 > /etc/default/locale


cp -frv /build/files/* / || true

source /usr/local/build_scripts/cleanup_apt.sh

