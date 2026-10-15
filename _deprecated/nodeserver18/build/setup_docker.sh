#!/bin/bash

set -x
set -e

# install node
ver=18
curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg
echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_$ver.x nodistro main" | tee /etc/apt/sources.list.d/nodesource.list
apt-get update && apt-get install -t nodistro nodejs -y

# install nodemon
npm install -g nodemon

# install yarn
npm install -g yarn

# Copy build files
cp -frv /build/files/* / || true

# Change www-data users home owner
chown -R www-data:www-data /var/www

# socat used as small proxy 80->NFQ_BACKEND_PORT
apt-get install -y --no-install-recommends socat

#cleanup
source /usr/local/build_scripts/cleanup_apt.sh

