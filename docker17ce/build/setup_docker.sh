#!/bin/bash

set -x
set -e

apt-get update

apt-get install -y apt-transport-https ca-certificates
echo 'deb https://apt.dockerproject.org/repo debian-jessie main' > /etc/apt/sources.list.d/docker.list
apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
apt-get update
# see link for version list: http://apt.dockerproject.org/repo/pool/main/d/docker-engine/
apt-get install -y docker-engine=17.03.0~ce-0~debian-jessie


cp -frv /build/files/* / || true


source /usr/local/build_scripts/cleanup_apt.sh

