#!/bin/bash

set -x
set -e

# Preparing MongoDB repository
wget -qO - https://www.mongodb.org/static/pgp/server-5.0.asc | \
gpg --dearmor > /etc/apt/trusted.gpg.d/mongodb-org-5.0.gpg
echo "deb http://repo.mongodb.org/apt/debian buster/mongodb-org/5.0 main" | \
tee /etc/apt/sources.list.d/mongodb-org-5.0.list

# Install dependencies
apt-get update
apt-get install -y --no-install-recommends mongodb-org-server mongodb-mongosh

# Prepare php code
mkdir  -p /var/www
cd /tmp
wget https://github.com/perftools/xhgui/archive/0.21.x.tar.gz -O xhgui.tar.gz
tar -xzvf xhgui.tar.gz --strip-components=1 -C /var/www/. xhgui-0.21.x

cd /var/www
export NFQ_ENABLE_PHP_MODULES='mongodb iconv mbstring tokenizer dom ctype xml simplexml'
/etc/rc.d/200-enable-php8-modules
export COMPOSER_VERSION=2
/etc/rc.d/800-composer-toggle
composer install --no-dev --prefer-dist
composer remove --dev phpunit/phpunit
composer require alcaeus/mongo-php-adapter --update-no-dev --prefer-dist --prefer-stable


# Copy runtime files
cp -frv /build/files/* /

# Start mongo
/usr/bin/mongod --nojournal --config /etc/mongod.conf &
MONGO_PID=$!

# Wait for mongo port available
until $(netcat -w 1 127.0.0.1 27017 < /dev/null > /dev/null 2>&1)
do
  sleep 1
done

# Create mongo indexes
mongosh < /build/init_mongo.js

# Kill mongo
kill -s SIGTERM $MONGO_PID


# Clean up APT when done.
source /usr/local/build_scripts/cleanup_apt.sh

