#!/bin/bash
set -e

run-parts -v /etc/rc.d

sed -i "s/NFQ_DB_USER/${NFQ_DB_USER}/" /var/www/phpmyadmin/config.inc.php
sed -i "s/NFQ_DB_PASSWORD/${NFQ_DB_PASSWORD}/" /var/www/phpmyadmin/config.inc.php

php -S 0.0.0.0:80 -t /var/www/phpmyadmin &
PHP_PID="$!"

function cleanup() {
	kill -SIGTERM $PHP_PID
}

trap cleanup EXIT

wait

