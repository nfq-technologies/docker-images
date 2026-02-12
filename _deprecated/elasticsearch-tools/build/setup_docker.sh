#!/bin/bash

set -x
set -e


apt-get update

rm -fr /var/www
mkdir -p /var/www


# HEAD setup ------------------------------------

cd /var/www/
wget https://github.com/mobz/elasticsearch-head/archive/master.zip
unzip master.zip
mv elasticsearch-head-master/_site head
chown -R www-data:www-data /var/www/head
rm -fr master.zip elasticsearch-head-master

# ----------------------------------------------

cp -frv /build/files/* / || true


source /usr/local/build_scripts/cleanup_apt.sh

