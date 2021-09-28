#!/bin/bash

set +e

# rabbitmq-server is in itself a shell script that doesnt
# use exec (ie, it wont replace init 1 with rabbitmq itself).
# Docker sends its stop signal to the containers init 1, which
# wont reach rabbitmq. This ends up timing out on the Docker-side
# for default 10 seconds, till we (the container) is getting killed.
# We need to trap SIGTERM to handle this.
PID=;
trap '[[ ${PID} ]] && /usr/sbin/rabbitmqctl stop; exit 0' SIGTERM

rabbitmq-server &
PID=$!

# Dont exit this script since we would loose our SIGTERM trap
wait


