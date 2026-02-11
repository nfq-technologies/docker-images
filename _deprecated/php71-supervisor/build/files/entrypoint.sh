#!/bin/bash

set -e

run-parts -v /etc/rc.d


DR="${NFQ_SUPERVISOR_CONF_DIR}"
if [ "x${DR}" != "x" ]
then
	echo "++ Waiting for config dir at $DR"
	while [ ! -d "$DR" ]
	do
	    sleep 1
	done
	echo "++ config dir at $DR found"

	echo "[include]" >> /etc/supervisor/supervisord.conf
	echo "files = ${NFQ_SUPERVISOR_CONF_DIR}/*.conf" >> /etc/supervisor/supervisord.conf
	echo >> /etc/supervisor/supervisord.conf
else
	echo "-- NFQ_SUPERVISOR_CONF_DIR is not set, supervisor won't do anything..."
fi

HT=$(echo "${NFQ_SUPERVISOR_ENABLE_HTTP}" | tr '[:upper:]' '[:lower:]')
if [ "x${HT}" = "xtrue" ]
then
	echo "++ Enabling supervisor http interface on port 9001."
	echo "[inet_http_server]" >> /etc/supervisor/supervisord.conf
	echo "port = :9001" >> /etc/supervisor/supervisord.conf
	echo >> /etc/supervisor/supervisord.conf
fi


ST=$(echo "${NFQ_USE_STARTUP_TRIGGER}" | tr '[:upper:]' '[:lower:]')
if [ "x${ST}" = "xtrue" ]
then
	echo Waiting for startup trigger on port 2048 ...
	netcat -l -p 2048 -c 'echo service startup triggered.'
fi


exec supervisord -nc /etc/supervisor/supervisord.conf

