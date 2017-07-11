#!/bin/bash

set -x
set -e

cp -frv /build/files/* / || true

rm -f /etc/rc.d/900-wait-for-web-root

# Clean up APT when done.
source /usr/local/build_scripts/cleanup_apt.sh
rm -rf /tmp/*

