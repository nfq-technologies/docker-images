#!/bin/bash

set -x
set -e


echo "deb http://ftp.lt.debian.org/debian/ jessie main non-free contrib" > /etc/apt/sources.list.d/nonfree.list
apt-get update
apt-get install -y --no-install-recommends apache2-mpm-worker ca-certificates libapache2-mod-fastcgi


rm -rf /var/www/*
mkdir -p /var/lock/apache2 /var/run/apache2 /var/log/apache2 /var/www
chown -R www-data:www-data /var/lock/apache2 /var/run/apache2 /var/log/apache2 /var/www


# disable all modules (that can be disabled)
ls -1 /etc/apache2/mods-enabled/ | cut -d. -f 1 | sort | uniq | xargs -n1 -I{} a2dismod {} >/dev/null 2>&1 || true

# enable few modules to make image somewhat usable in default configuration
a2enmod mpm_event actions fastcgi


rm -rf /var/www/*
mkdir -p /var/lock/apache2 /var/run/apache2 /var/log/apache2 /var/www
chown -R www-data:www-data /var/lock/apache2 /var/run/apache2 /var/log/apache2 /var/www

mv /etc/apache2/apache2.conf /etc/apache2/apache2.conf.dist


cp -frv /build/files/* /


# Clean up APT when done.
source /usr/local/build_scripts/cleanup_apt.sh
rm -rf /tmp/*













