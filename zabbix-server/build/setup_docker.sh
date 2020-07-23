#!/bin/bash
set -ex

apt-get update

# Remove useless mysql dependencies
wget https://repo.zabbix.com/zabbix/5.0/debian/pool/main/z/zabbix/zabbix-server-mysql_5.0.2-1%2Bbuster_amd64.deb -O /tmp/zabbix.deb
#dpkg-deb -x /tmp/zabbix.deb /tmp/zabbix
#dpkg-deb -e /tmp/zabbix.deb /tmp/zabbix/DEBIAN
#sed -i 's/ mysql-client / bash /' /tmp/zabbix/DEBIAN/control
#dpkg -b /tmp/zabbix /tmp/zabbix.deb

# Install zabbix-server and its dependencies
dpkg -i /tmp/zabbix.deb || apt-get -f install -y

# don't ask...
mkdir /var/run/zabbix

# Copy runtime files
cp -frv /build/files/* / || true
  
source /usr/local/build_scripts/cleanup_apt.sh

