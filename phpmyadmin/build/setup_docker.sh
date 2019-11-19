#!/bin/bash

set -x
set -e


apt-get update

rm -fr /var/www
mkdir -p /var/www


# PHP setup ------------------------------------

cd /var/www/
wget -O phpmyadmin.zip https://www.phpmyadmin.net/downloads/phpMyAdmin-latest-all-languages.zip
unzip phpmyadmin.zip
rm -rf phpmyadmin.zip

mv phpMyAdmin-*-all-languages phpmyadmin
# ----------------------------------------------

cp -frv /build/files/* / || true


source /usr/local/build_scripts/cleanup_apt.sh

