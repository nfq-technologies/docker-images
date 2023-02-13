#!/bin/bash

set -e

run-parts -v /etc/rc.d

source /tools/functions_init.sh

# default features
init_use_startup_trigger
init_wait_for_a_dir
init_wait_for_a_not_empty_dir
init_wait_for_a_file
init_wait_for_a_not_empty_file

# For tests when container does not have a link to fastcgi

if [ ! -d "/builds/" ] && ! fgrep -q fastcgi /etc/hosts && ! host fastcgi; then
	echo "No fastcgi host found, injecting localhost"
	echo "127.0.0.1 fastcgi" >> /etc/hosts
fi

exec apache2 -T -DFOREGROUND

