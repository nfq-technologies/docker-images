#!/bin/bash

set -x
set -e

apt-get update

apt-get install -y --no-install-recommends git git-flow





cp -frv /build/files/* / || true


# Clean up APT when done.
source /usr/local/build_scripts/cleanup_apt.sh

