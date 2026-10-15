#!/bin/bash

set -x
set -e

apt-get update
apt-get install -y --no-install-recommends php8.0-fpm

# remove php modules
rm -f /etc/php/8.0/fpm/conf.d/*


cp -frv /build/files/* / || true


# Clean up APT when done.
source /usr/local/build_scripts/cleanup_apt.sh

