#!/bin/bash

set -x
set -e

# Update apt repos
apt-get update

# Install python
apt-get install --no-install-recommends -y python3-venv

# Creating and activating virtual environment
python3 -m venv /python; source /python/bin/activate

# Install installer dependencies
pip install -U pip

# Install moto and flask
pip install moto
pip install flask-cors docker

cp -frv /build/files/* / || true


# Clean up APT when done.
source /usr/local/build_scripts/cleanup_apt.sh
rm -rf /tmp/*

