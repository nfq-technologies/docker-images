#!/bin/bash
set -e

/entrypoint.sh &
esPid=$!

source /build/helpers/common.sh

wait_for_connection "localhost:9200" 15
wget "localhost:9200/" -O -

kill $esPid
wait

tar cf /backup.tar /var/elasticsearch/data
sync

