#!/bin/bash
set -ex

apt-get update

# Zabbix server
wget https://repo.zabbix.com/zabbix/5.0/debian/pool/main/z/zabbix/zabbix-server-mysql_5.0.2-1%2Bbuster_amd64.deb -O /tmp/zabbix.deb

# Install zabbix-server and its dependencies
dpkg -i /tmp/zabbix.deb || apt-get -f install -y

# don't ask...
mkdir /var/run/zabbix

# Zabbix frontend
wget https://repo.zabbix.com/zabbix/5.0/debian/pool/main/z/zabbix/zabbix-frontend-php_5.0.2-1%2Bbuster_all.deb -O /tmp/zabbix-front.deb

# We don't need php here, so extracting just the source
dpkg-deb -x /tmp/zabbix-front.deb /tmp/zabbix-front
mv /tmp/zabbix-front/usr/share/zabbix /usr/share/
chown -R 1000:1000 /usr/share/zabbix

# Prepare zabix frontend config
rm /usr/share/zabbix/conf/zabbix.conf.php
mv /usr/share/zabbix/conf/zabbix.conf.php.example /usr/share/zabbix/conf/zabbix.conf.php

# Cleanup
rm -rf /tmp/zabbix*

# Copy runtime files
cp -frv /build/files/* / || true
  
source /usr/local/build_scripts/cleanup_apt.sh

