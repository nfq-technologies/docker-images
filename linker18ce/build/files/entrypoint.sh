#!/bin/bash

set +x


if [ ! -S /run/docker.sock ]
then
    sleep 2
    echo -e "\nERROR: docker socket not found at /run/docker.sock\n"
    exit 1
fi

trap 'echo Terminating...' SIGTERM

/usr/local/bin/container_linker.sh &

wait

