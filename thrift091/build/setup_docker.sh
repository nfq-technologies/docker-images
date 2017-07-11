#!/bin/bash

set -x
set -e


apt-get update

# Installing thrift
apt-get install -y --no-install-recommends thrift-compiler=0.9.1-\*


# Copy runtime files
cp -frv /build/files/* / || true

# Clean up APT when done.
source /usr/local/build_scripts/cleanup_apt.sh

