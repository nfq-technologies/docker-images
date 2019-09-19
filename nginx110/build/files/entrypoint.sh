#!/bin/bash
set -e

source /tools/functions_init.sh

# for tests when container does not have a link to fastcgi
if ! fgrep -q fastcgi /etc/hosts && ! host fastcgi; then
	echo "No fastcgi host found, injecting localhost"
	echo "127.0.0.1 fastcgi" >> /etc/hosts
fi

run-parts -v /etc/rc.d

# default features
init_wait_for_a_dir
init_wait_for_a_not_empty_dir
init_wait_for_a_file
init_wait_for_a_not_empty_file

/usr/local/bin/prepare_nginx_configs

# We'll use exec so current process id should be substituted with nginx master
PID="$$"

# Do a gracefull reload of nginx on call to a NFQ_RELOAD_PORT
function reload_nginx() {
		while true; do
			netcat -l -p "$NFQ_RELOAD_PORT" -c "echo '++ Reloading configuration' && /usr/local/bin/prepare_nginx_configs && kill -1 $PID"
		done
}
reload_nginx &

# Start NGINX
exec nginx -g "daemon off;"

