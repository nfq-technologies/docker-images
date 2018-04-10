#!/bin/bash

set -e

source /tools/functions_init.sh

run-parts /etc/rc.d


cfg_dir=/etc/td-agent
cfg_file=$cfg_dir/td-agent.conf
tpl_dir=$cfg_dir/tpl.d

if [ -n "$NFQ_LOG_TO_FILE" ]
then
	echo "++ Output saving to file"

	log_dir="$(dirname "$NFQ_LOG_TO_FILE")"

	cat "$tpl_dir/output_file" \
	| sed "s~{{OUTPUT_FILE}}~$NFQ_LOG_TO_FILE~" \
	>> $cfg_file

	init_wait_for_a_dir "$log_dir"
fi

if [ -n "$NFQ_LOG_TO_AGREGATOR" ]
then
	echo "++ Output forwarding to agregator"


	host="$(echo "$NFQ_LOG_TO_AGREGATOR" | cut -d: -f1)"
	port="$(echo "$NFQ_LOG_TO_AGREGATOR" | cut -d: -f2)"
	: "${port:=24224}"

	cat "$tpl_dir/output_forward" \
	| sed "s~{{OUTPUT_HOST}}~$host~" \
	| sed "s~{{OUTPUT_PORT}}~$port~" \
	>> $cfg_file


	echo "++ Waiting for $host:$port"
	if init_wait_for_connection_nc "$host" "$port" 120
	then
		echo "++ Connection to $host:$port established."
	else
		echo "-- Connection to $host:$port TIMED OUT"
		exit 1
	fi
fi

if [[ -z "$NFQ_LOG_TO_FILE" && -z "$NFQ_LOG_TO_AGREGATOR" ]]
then
	echo "~~ Output to stdout"

	cat "$tpl_dir/output_stdout" >> $cfg_file
fi


exec /usr/sbin/td-agent

