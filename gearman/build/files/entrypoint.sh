#!/bin/bash

set -e

run-parts -v /etc/rc.d

echo "++ verbose mode: ${NFQ_GEARMAND_VERBOSE}"
GEAR_VERBOSE=" --verbose ${NFQ_GEARMAND_VERBOSE}"

if [ "x${NFQ_GEARMAND_CONFIG}" != "x" ]
then
	echo "++ Waiting for file at ${NFQ_GEARMAND_CONFIG}"
	while [ ! -f "${NFQ_GEARMAND_CONFIG}" ]
	do
	    sleep 1
	done
	echo "++ config file found at ${NFQ_GEARMAND_CONFIG} found"

	GEAR_CONFIG=" --config-file  ${NFQ_GEARMAND_CONFIG}"
else
	GEAR_CONFIG=""
fi

exec gearmand ${GEAR_VERBOSE} ${GEAR_CONFIG} --log-file /dev/stdout
