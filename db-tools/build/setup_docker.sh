#!/bin/bash

set -x
set -e

# Update apt repos
apt-get update

# Install mdbtools
apt-get install --no-install-recommends -y mdbtools

# Install sqlite3
apt-get install --no-install-recommends -y sqlite3

# Copy runtime files
cp -frv /build/files/* / || true

# Clean up APT when done.
source /usr/local/build_scripts/cleanup_apt.sh

