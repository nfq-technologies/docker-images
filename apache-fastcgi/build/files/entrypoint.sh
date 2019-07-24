#!/bin/bash
set -e

run-parts -v /etc/rc.d

# For tests when container does not have a link to fastcgi

if ! fgrep -q fastcgi /etc/hosts && ! host fastcgi; then
		echo "No fastcgi host found, injecting localhost"
		echo "127.0.0.1 fastcgi" >> /etc/hosts
fi

exec apache2 -DFOREGROUND

