#!/bin/bash

host="{{ host }}"
remote_path="{{ remote_path }}"

source /tools/functions_init.sh

if [[ ! -f "/dev/shm/${host}-alive" ]]; then
    if ! init_wait_for_connection_nc "$host" 22 20; then
        echo "Can't connect to $host container"
        exit 1
    fi

    touch "/dev/shm/${host}-alive"
fi

for x in "$@"; do
    params="$params '$x'"
done

wd="$(pwd)"
ssh -t -o StrictHostKeyChecking=no -q project@$host  "cd $wd; '$remote_path' $params"

