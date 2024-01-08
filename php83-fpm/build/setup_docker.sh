#!/bin/bash

set -x
set -e

apt-get update
apt-get install -y --no-install-recommends php8.3-fpm

# remove php modules
rm -f /etc/php/8.3/fpm/conf.d/*


cp -frv /build/files/* / || true


# Clean up APT when done.
source /usr/local/build_scripts/cleanup_apt.sh

