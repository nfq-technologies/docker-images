#!/bin/bash

set -x
set -e

# Install dependencies
apt-get update

# Requiraments
apt-get install -y --no-install-recommends --allow-unauthenticated phyaml

# Copy runtime files
cp -frv /build/files/* / | true

# Clean up APT when done.
source /usr/local/build_scripts/cleanup_apt.sh

