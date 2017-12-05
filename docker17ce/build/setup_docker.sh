#!/bin/bash

set -x
set -e

apt-get update

echo -e '\n\n## Install and configure docker ... \n\n'

apt-get install -y apt-transport-https ca-certificates
echo 'deb [arch=amd64] https://download.docker.com/linux/debian stretch stable' > /etc/apt/sources.list.d/docker.list
curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add -
apt-get update
apt-get install -y docker-ce=17.03.0~ce-0~debian-stretch


cp -frv /build/files/* / || true


source /usr/local/build_scripts/cleanup_apt.sh

