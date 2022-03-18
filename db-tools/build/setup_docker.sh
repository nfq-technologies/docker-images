#!/bin/bash

set -x
set -e

# Preparing MongoDB repository
wget -qO - https://www.mongodb.org/static/pgp/server-5.0.asc | \
gpg --dearmor > /etc/apt/trusted.gpg.d/mongodb-org-5.0.gpg
echo "deb http://repo.mongodb.org/apt/debian buster/mongodb-org/5.0 main" | \
tee /etc/apt/sources.list.d/mongodb-org-5.0.list

# Update apt repos
apt-get update

# Install mdbtools
apt-get install --no-install-recommends -y mdbtools

# Install sqlite3
apt-get install --no-install-recommends -y sqlite3

# Install psql client
apt-get install --no-install-recommends -y postgresql-client

# Install mysql-client
apt-get install --no-install-recommends -y mariadb-client

# Install mongodb shell
apt-get install --no-install-recommends -y mongodb-mongosh

# Copy runtime files
cp -frv /build/files/* / || true

# Clean up APT when done.
source /usr/local/build_scripts/cleanup_apt.sh

