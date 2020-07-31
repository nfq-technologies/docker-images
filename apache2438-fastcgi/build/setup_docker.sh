#!/bin/bash

set -x
set -e


apt-get update
apt-get install -y --no-install-recommends apache2 ca-certificates libapache2-mod-fcgid


rm -rf /var/www/*
mkdir -p /var/lock/apache2 /var/run/apache2 /var/log/apache2 /var/www
chown -R www-data:www-data /var/lock/apache2 /var/run/apache2 /var/log/apache2 /var/www


# disable all modules (that can be disabled)
ls -1 /etc/apache2/mods-enabled/ | cut -d. -f 1 | sort | uniq | xargs -n1 -I{} a2dismod {} >/dev/null 2>&1 || true
ls -1 /etc/apache2/mods-enabled/ | cut -d. -f 1 | sort | uniq | xargs -n1 -I{} a2dismod {} >/dev/null 2>&1 || true
ls -1 /etc/apache2/mods-enabled/ | cut -d. -f 1 | sort | uniq | xargs -n1 -I{} a2dismod {} >/dev/null 2>&1 || true

# enable few modules to make image somewhat usable in default configuration
ls -1 /etc/apache2/mods-available/ | cut -d. -f1 | sort -u
a2enmod mpm_event actions proxy proxy_fcgi

echo > /etc/apache2/sites-enabled/000-default.conf

rm -rf /var/www/*
mkdir -p /var/lock/apache2 /var/run/apache2 /var/log/apache2 /var/www
chown -R www-data:www-data /var/lock/apache2 /var/run/apache2 /var/log/apache2 /var/www

mv /etc/apache2/apache2.conf /etc/apache2/apache2.conf.dist


cp -frv /build/files/* /


# Clean up APT when done.
source /usr/local/build_scripts/cleanup_apt.sh
rm -rf /tmp/*


