#!/bin/bash
set -e

/entrypoint.sh &
esPid=$!

source /build/helpers/common.sh

wait_for_connection "localhost:9200" 30
wget "localhost:9200/" -O -

# set default shards and replicas
curl -H 'Content-Type: application/json' -XPUT -d '{"template":"*","settings":{"number_of_shards":2,"number_of_replicas":0}}' http://localhost:9200/_template/default
sleep 10

kill $esPid
wait

tar cf /backup.tar /var/elasticsearch/data
sync

