#!/bin/bash

set -x
set -e

# Install chromium
apt-get update
apt-get install -y --no-install-recommends chromium=70.0.3538.110-1~deb9u1

# Copy runtime files
cp -frv /build/files/* / || true

# Clean up APT when done.
source /usr/local/build_scripts/cleanup_apt.sh

