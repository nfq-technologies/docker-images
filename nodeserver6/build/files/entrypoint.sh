#!/bin/bash

set -e
run-parts -v /etc/rc.d

source /tools/functions_init.sh

# default features
init_wait_for_a_dir
init_wait_for_a_not_empty_dir
init_wait_for_a_file
init_wait_for_a_not_empty_file
init_use_startup_trigger


echo "++ Document root is: $NFQ_DOCUMENT_ROOT"
cd $NFQ_DOCUMENT_ROOT

if [ -z "$NFQ_NPM_RUN" ]; then
	echo "--ERROR: NFQ_NPM_RUN is not defined, nothing to run"
	exit 1
fi

echo "++ Executing npm"

# On SIGTERM kill children
trap 'kill -s SIGTERM $NPM_PID; kill -s SIGTERM $SOCAT_PID; exit 0' SIGTERM

# Run thin proxy
echo "++ Forwarding port 80 to $NFQ_BACKEND_PORT"
/usr/bin/socat TCP4-LISTEN:80,fork TCP4:127.0.0.1:$NFQ_BACKEND_PORT &
SOCAT_PID=$!

# Run npm target
sudo -HEu www-data npm run "$NFQ_NPM_RUN" &
NPM_PID=$!

wait

