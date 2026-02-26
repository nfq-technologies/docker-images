#!/bin/bash

set -x
set -e

apt-get update
apt-get install -y --no-install-recommends supervisor


cp -frv /build/files/* / || true


# Clean up APT when done.
source /usr/local/build_scripts/cleanup_apt.sh

