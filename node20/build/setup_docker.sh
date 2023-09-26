#!/bin/bash

set -x
set -e

arch="$([ "`uname -m`" = "aarch64" ] && echo "arm64" || echo "amd64")"

# install node
ver=20
curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg
echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_$ver.x nodistro main" | tee /etc/apt/sources.list.d/nodesource.list
apt-get update && apt-get install -t nodistro nodejs -y

# yarn
npm install -g yarn

# grunt
npm install -g grunt-cli

# sass
npm install -g sass --unsafe

# gulp
npm install -g gulp-cli

# bower
npm install -g bower

# uglify js
npm install -g uglify-js

# uglifycss
npm install -g uglifycss

# typescript
npm install -g typescript

# typescript linter
npm install -g tslint

# typescript executor
npm install -g ts-node

# Copy runtime files
cp -frv /build/files/* / || true

# Clean up APT when done.
source /usr/local/build_scripts/cleanup_apt.sh

