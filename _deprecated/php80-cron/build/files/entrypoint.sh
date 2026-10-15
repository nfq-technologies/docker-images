#!/bin/bash

set -e
source /tools/functions_init.sh

# abandon all children, init proccess will take care of them on exit
trap 'exec true' EXIT

/entrypoint-cli.sh

run-parts -v /etc/rc.d


# default features
init_use_startup_trigger
init_wait_for_a_dir
init_wait_for_a_not_empty_dir
init_wait_for_a_file
init_wait_for_a_not_empty_file


watch_cron_files() {
	local DR="$1"
	local c1=""
	local c2=""
	while [[ true ]]
	do
        sleep 5
		c2="$(md5sum $DR/*)"
        if [[ $c1 != $c2 ]] ; then
			echo "~~ Changes detected, updating crontab."
            cat ${DR}/* > /etc/crontab
            c1=$c2
        fi
    done
}
crond_dir() {
	local DR="${NFQ_CRON_D_PATH}"
	init_wait_for_a_not_empty_dir "$DR"

	if [ "x$DR" != "x" ]
	then
		echo "++ Using $DR as a cron.d dir."
		watch_cron_files "$DR" &
	else
		echo "-- cron.d location is not set in NFQ_CRON_D_PATH var. This container has nothing to do now."
	fi
}

crond_dir




cron -n -L 1 &
syslogd -n -O /dev/stdout | stdbuf -i0 -oL -eL fgrep -v ' authpriv.'


