#!/bin/bash

set -e

# On SIGTERM kill children
trap 'kill -s SIGTERM $PHP_PID; kill -s SIGTERM $MONGO_PID; exit 0' SIGTERM

# Start mongo
/usr/bin/mongod --smallfiles --quota --quotaFiles 1 --nojournal --config /etc/mongodb.conf &
MONGO_PID=$!

# Wait for mongo port available
until $(netcat -w 1 127.0.0.1 27017 < /dev/null > /dev/null 2>&1)
do
  sleep 1
done

# Start up web server
php -S 0:80 -t /var/www/webroot &
PHP_PID=$!

wait
