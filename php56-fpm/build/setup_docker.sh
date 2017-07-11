#!/bin/bash

set -x
set -e

apt-get update
apt-get install -y --no-install-recommends php5-fpm


rm -f /etc/php5/fpm/conf.d/*


cp -frv /build/files/* /


# Clean up APT when done.
source /usr/local/build_scripts/cleanup_apt.sh

