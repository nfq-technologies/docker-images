#!/bin/bash

set -x
set -e

arch="$([ "`uname -m`" = "aarch64" ] && echo "aarch64" || echo "x86_64")"

# Update apt repos
apt-get update

# Install python
apt-get install --no-install-recommends -y python3-venv

# Creating and activating virtual environment
python3 -m venv /python; source /python/bin/activate

# Install installer dependencies
pip install -U pip

# The actual install
pip install PyYAML==5.3.1 awsebcli

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
