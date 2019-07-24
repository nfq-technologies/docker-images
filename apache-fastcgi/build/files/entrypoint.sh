#!/bin/bash
run-parts -v /etc/rc.d

# Clenup children
trap 'kill $apache_pid $monitor_pid;' EXIT

# For tests when container does not have a link to fastcgi
fcgi_value="127.0.0.1 fastcgi"
fgrep -q fastcgi /etc/hosts || echo "$fcgi_value" >> /etc/hosts

function monitor() {
	apache2 -DFOREGROUND &
	apache_pid="$!"

	while true; do
		cur_value="$(fgrep fastcgi /etc/hosts)"
		if [[ "$fcgi_value" !=  "$cur_value" ]]; then
				echo "FCGI ip change detected, reloading apache"
				kill "$apache_pid"
				wait "$apache_pid"

				fcgi_value="$cur_value"
				apache2 -DFOREGROUND &
				apache_pid="$!"
		fi
		sleep 1
done
}

monitor &
monitor_pid="$!"

wait

