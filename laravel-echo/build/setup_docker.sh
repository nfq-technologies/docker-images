#!/bin/bash

set -x
set -e


rm -f /var/www/server.js

cd /var/www/
npm install laravel-echo-server



cp -frv /build/files/* / || true

# Change www-data users home owner
chown -R www-data:www-data /var/www

#cleanup
source /usr/local/build_scripts/cleanup_apt.sh

