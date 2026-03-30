#!/bin/bash

set -x
set -e

apt-get update

echo -e '\n\n## Install and configure docker ... \n\n'

# Install Docker CE CLI from official Docker repo (API 1.44+)
apt-get install -y apt-transport-https ca-certificates curl
install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
chmod a+r /etc/apt/keyrings/docker.asc
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian bullseye stable" > /etc/apt/sources.list.d/docker.list
apt-get update
apt-get install -y docker-ce-cli docker-compose-plugin

# Add compatibility symlink for old docker-compose calls
ln -s /usr/libexec/docker/cli-plugins/docker-compose /usr/local/bin/docker-compose

cp -frv /build/files/* / || true


source /usr/local/build_scripts/cleanup_apt.sh

