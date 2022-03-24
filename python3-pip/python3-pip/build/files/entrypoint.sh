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


# On SIGTERM kill children
trap 'kill -s SIGTERM $NPM_PID; kill -s SIGTERM $SOCAT_PID; exit 0' SIGTERM

