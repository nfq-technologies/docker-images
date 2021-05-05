#!/bin/bash

set -x
set -e

# add grafana key
wget -q -O - https://packages.grafana.com/gpg.key | sudo apt-key add -
apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 8C8C34C524098CB6
echo "deb https://packages.grafana.com/oss/deb stable main" | tee -a /etc/apt/sources.list.d/grafana.list

cp -frv /build/files/* /

apt update
apt install -y grafana


source /usr/local/build_scripts/cleanup_apt.sh

