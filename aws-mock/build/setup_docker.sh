#!/bin/bash

set -x
set -e


apt-get update

# install pip
apt-get install -y --no-install-recommends python3-pip python3-wheel python3-setuptools

# Install installer dependencies
python3 -m pip install -U pip

# install moto and flask
pip install moto
pip install flask


cp -frv /build/files/* / || true


# Clean up APT when done.
source /usr/local/build_scripts/cleanup_apt.sh
rm -rf /tmp/*

