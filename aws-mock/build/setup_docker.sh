#!/bin/bash

set -x
set -e


apt-get update

# install pip
apt-get install -y --no-install-recommends python3-pip python3-wheel python3-setuptools

# install moto and flask
pip3 install moto
pip3 install flask


cp -frv /build/files/* / || true


# Clean up APT when done.
source /usr/local/build_scripts/cleanup_apt.sh
rm -rf /tmp/*

