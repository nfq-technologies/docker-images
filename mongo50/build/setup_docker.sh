#!/bin/bash

set -x
set -e

# Preparing MongoDB repository
wget -qO - https://www.mongodb.org/static/pgp/server-5.0.asc | \
gpg --dearmor > /etc/apt/trusted.gpg.d/mongodb-org-5.0.gpg
echo "deb http://repo.mongodb.org/apt/debian buster/mongodb-org/5.0 main" | \
tee /etc/apt/sources.list.d/mongodb-org-5.0.list

apt-get update

apt-get install -y --no-install-recommends mongodb-org-server mongodb-mongosh

cp /etc/mongod.conf{,.orig}

cp -frv /build/files/* /


source /usr/local/build_scripts/cleanup_apt.sh

