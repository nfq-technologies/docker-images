#!/bin/bash

set -x
set -e

# Install dependencies
apt-get update
apt-get install -y --no-install-recommends mongodb-server

# Prepare php code
mkdir  -p /var/www
cd /tmp
wget https://github.com/perftools/xhgui/archive/0.11.0.tar.gz -O xhgui.tar.gz
tar -xzvf xhgui.tar.gz --strip-components=1 -C /var/www/. xhgui-0.11.0

cd /var/www
export NFQ_ENABLE_PHP_MODULES='mongodb mcrypt json iconv mbstring tokenizer dom ctype xml'
/etc/rc.d/200-enable-php7-modules
composer install --no-dev --prefer-dist
composer remove --dev phpunit/phpunit
composer require alcaeus/mongo-php-adapter --update-no-dev --prefer-dist --prefer-stable


# Copy runtime files
cp -frv /build/files/* /

# Start mongo
/usr/bin/mongod --smallfiles --quota --quotaFiles 1 --nojournal --config /etc/mongodb.conf &
MONGO_PID=$!

# Wait for mongo port available
until $(netcat -w 1 127.0.0.1 27017 < /dev/null > /dev/null 2>&1)
do
  sleep 1
done

# Create mongo indexes
mongo < /build/init_mongo.js

# Kill mongo
kill -s SIGTERM $MONGO_PID


# Clean up APT when done.
source /usr/local/build_scripts/cleanup_apt.sh

