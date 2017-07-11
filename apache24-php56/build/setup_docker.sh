#!/bin/bash

set -x
set -e


apt-get update

apt-get install -y --no-install-recommends libapache2-mod-php5


# disable all modules (that can be disabled)
ls -1 /etc/apache2/mods-enabled/ | cut -d. -f 1 | sort | uniq | xargs -n1 -I{} a2dismod {} >/dev/null 2>&1 || true

# enable few modules to make image somewhat usable in default configuration
a2enmod mpm_prefork php5


rm -rf /var/www/*
mkdir -p /var/lock/apache2 /var/run/apache2 /var/log/apache2 /var/www
chown -R www-data:www-data /var/lock/apache2 /var/run/apache2 /var/log/apache2 /var/www

mv /etc/apache2/apache2.conf /etc/apache2/apache2.conf.dist


cp -frv /build/files/* /


# Clean up APT when done.
source /usr/local/build_scripts/cleanup_apt.sh
rm -rf /tmp/*
mkdir -m 700 /tmp/php-sess && chown www-data:www-data /tmp/php-sess

