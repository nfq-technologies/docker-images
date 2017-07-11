#!/bin/bash

set -x
set -e

# Install dependencies
echo "deb http://http.debian.net/debian jessie-backports main" >> /etc/apt/sources.list

apt-get update
apt-get install -y --no-install-recommends ffmpeg

# Copy runtime files
cp -frv /build/files/* / | true

# Clean up APT when done.
source /usr/local/build_scripts/cleanup_apt.sh
