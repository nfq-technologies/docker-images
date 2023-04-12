#!/bin/bash

set -x
set -e

arch="$([ "`uname -m`" = "aarch64" ] && echo "aarch64" || echo "x86_64")"

# Update apt repos
apt-get update

# Install python dependencies
apt-get install --no-install-recommends -y python3-pip python3-setuptools

# Install installer dependencies
python3 -m pip install -U pip

# The actual install
pip install awsebcli

# Install awscli v2
curl "https://awscli.amazonaws.com/awscli-exe-linux-$arch.zip" -o "awscliv2.zip"
unzip awscliv2.zip
./aws/install
rm -rf awscliv2.zip ./aws

# Copy runtime files
cp -frv /build/files/* / || true

# Chown project home to project
chown -R project:project /home/project

# Clean up APT when done.
source /usr/local/build_scripts/cleanup_apt.sh
