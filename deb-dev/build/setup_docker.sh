#!/bin/bash

set -x
set -e

apt-get update


# package building and publishing tools
apt-get install -y --no-install-recommends make lintian aptly inotify-tools
apt-get install -y --no-install-recommends apt-file debhelper dh-make


cp -frv /build/files/* / || true


# Clean up APT when done.
source /usr/local/build_scripts/cleanup_apt.sh

