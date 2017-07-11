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

exec spawn-fcgi -n -C 3 -p 9000 -u www-data -- /usr/bin/php5-cgi -d log_errors=1 -d error_log=$LOG

