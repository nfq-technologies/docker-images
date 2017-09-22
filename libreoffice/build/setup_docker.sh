#!/bin/bash

set -x
set -e

# Install dependencies
apt-get update
apt-get install -y --no-install-recommends openjdk-8-jre-headless
apt-get install -y --no-install-recommends libreoffice

# Copy runtime files
cp -frv /build/files/* / || true

# Clean up APT when done.
source /usr/local/build_scripts/cleanup_apt.sh

