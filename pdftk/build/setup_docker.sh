#!/bin/bash

set -x
set -e

# Install stuff
apt-get update
apt-get install -y --no-install-recommends pdftk


# Copy runtime files
cp -frv /build/files/* / || true


# Clean up APT when done.
source /usr/local/build_scripts/cleanup_apt.sh

