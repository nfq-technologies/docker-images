#!/bin/bash

set -x
set -e

# Install dependencies
apt-get update
apt-get install -y --no-install-recommends ca-certificates mongodb-server php5-cli php5-mongo php5-mcrypt

# Prepare php code
mkdir  -p /var/www
cd /build
tar -xzvf xhgui.tar.gz -C /var/www/.

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
