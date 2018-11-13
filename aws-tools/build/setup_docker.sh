#!/bin/bash

set -x
set -e

# Update apt repos
apt-get update

# Install dependencies
apt-get install --no-install-recommends -y python3-pip python3-setuptools

pip3 install awscli
pip3 install awsebcli


# Copy runtime files
cp -frv /build/files/* / || true

# Clean up APT when done.
source /usr/local/build_scripts/cleanup_apt.sh

