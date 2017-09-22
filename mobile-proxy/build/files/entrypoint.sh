#!/bin/bash
set -e

source /tools/functions_init.sh

run-parts -v /etc/rc.d

init_wait_for_connection web:80 0

exec nginx -g "daemon off;"

