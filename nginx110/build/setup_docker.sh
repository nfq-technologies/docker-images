#!/bin/bash

set -x
set -e


apt-get update

apt-get install -y --no-install-recommends nginx openssl ca-certificates


cp -frv /build/files/* / || true


# Clean up APT when done.
source /usr/local/build_scripts/cleanup_apt.sh
rm -rf /tmp/*

