#!/bin/bash
set -ex

/entrypoint.sh &
mongoPid=$!

while ! echo "show dbs" | mongosh &> /dev/null; do
	sleep 1
done

kill $mongoPid
wait

tar cf /backup.tar /var/lib/mongodb
sync

