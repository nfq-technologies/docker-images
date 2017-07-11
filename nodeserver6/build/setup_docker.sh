#!/bin/bash

set -x
set -e

# Install nodejs dependencies
apt-get update
apt-get install -y --no-install-recommends rlwrap


# Manually download and install node deb
wget -qO nodejs.deb https://deb.nodesource.com/node_6.x/pool/main/n/nodejs/nodejs_6.1.0-1nodesource1~jessie1_amd64.deb
dpkg -i nodejs.deb

cp -frv /build/files/* / || true

# Change www-data users home owner
chown -R www-data:www-data /var/www

# socat used as small proxy 80->3000
apt-get install -y --no-install-recommends socat

#cleanup
rm -r nodejs.deb

source /usr/local/build_scripts/cleanup_apt.sh

