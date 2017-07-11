#!/bin/bash

set -x
set -e


apt-get update

apt-get install -y --no-install-recommends libapache2-mod-php5


rm -rf /var/www/*
mkdir -p /var/lock/apache2 /var/run/apache2 /var/log/apache2 /var/www
chown -R www-data:www-data /var/lock/apache2 /var/run/apache2 /var/log/apache2 /var/www


cp -frv /build/files/* /


# Clean up APT when done.
source /usr/local/build_scripts/cleanup_apt.sh
rm -rf /tmp/*
mkdir -m 700 /tmp/php-sess && chown www-data:www-data /tmp/php-sess

