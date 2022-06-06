#!/bin/bash

set -x
set -e

# Update apt repos
apt-get update

# Install docker dependencies
apt-get install --no-install-recommends -y docker.io

# Copy runtime files
cp -frv /build/files/* / || true

# Clean up APT when done.
source /usr/local/build_scripts/cleanup_apt.sh
