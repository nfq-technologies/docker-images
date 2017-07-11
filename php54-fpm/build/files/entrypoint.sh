#!/bin/bash

set -e
set -x

run-parts -v /etc/rc.d


# setup logging to stderror
LOG=/dev/shm/fpm-log
mkfifo -m 666 $LOG

set +x
while true; do cat $LOG >&2; done &
set -x

exec php5-fpm -F --fpm-config /etc/php5/fpm/php-fpm.conf -d log_errors=1 -d error_log=$LOG


