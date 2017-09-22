#!/bin/bash

set -x
set -e

# Install fontforge
apt-get update
apt-get install -y --no-install-recommends rlwrap python

# Manually download and install node deb
file=$(wget -qO - https://deb.nodesource.com/node_8.x/pool/main/n/nodejs/ | sed 's/href="\([^"]*\)">/\n\1\n/g' | grep -i '^nodejs_[0-9\.\-]*nodesource1.stretch1_amd64\.deb$' | tail -n1)
wget -qO nodejs.deb https://deb.nodesource.com/node_8.x/pool/main/n/nodejs/$file
dpkg -i nodejs.deb
. /etc/profile.d/nodejs.sh
rm nodejs.deb

# grunt
npm install -g grunt-cli

# sass
npm install -g node-sass --unsafe

# gulp
npm install -g gulp-cli

# bower
npm install -g bower

# uglify js
npm install -g uglify-js

# uglifycss
npm install -g uglifycss

# Copy runtime files
cp -frv /build/files/* / || true

# Clean up APT when done.
source /usr/local/build_scripts/cleanup_apt.sh

