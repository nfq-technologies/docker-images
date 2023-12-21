#!/bin/bash

set -e
set -x

/entrypoint-cli.sh

run-parts -v /etc/rc.d


# setup logging to stderror
LOG=/dev/shm/fpm-log
mkfifo -m 666 $LOG

set +x
while true; do
	 cat $LOG >&2
done &
set -x

exec php-fpm8.3 -F --fpm-config /etc/php/8.3/fpm/php-fpm.conf -d log_errors=1 -d error_log=$LOG

