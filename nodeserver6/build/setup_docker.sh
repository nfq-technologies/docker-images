#!/bin/bash

set -x
set -e

# Install nodejs dependencies
apt-get update
apt-get install -y --no-install-recommends rlwrap


# Manually download and install node deb
file=$(wget -qO - https://deb.nodesource.com/node_6.x/pool/main/n/nodejs/ | sed 's/href="\([^"]*\)">/\n\1\n/g' | grep -i '^nodejs_[0-9\.\-]*nodesource1.stretch1_amd64\.deb$' | tail -n1)
wget -qO nodejs.deb https://deb.nodesource.com/node_6.x/pool/main/n/nodejs/$file
dpkg -i nodejs.deb
. /etc/profile.d/nodejs.sh
rm nodejs.deb


cp -frv /build/files/* / || true

# Change www-data users home owner
chown -R www-data:www-data /var/www

# socat used as small proxy 80->3000
apt-get install -y --no-install-recommends socat

#cleanup
source /usr/local/build_scripts/cleanup_apt.sh

