#!/bin/bash
set -e

/docker-entrypoint.sh postgres &
psqlPid=$!

while ! psql -U postgres -c "\c project"; do
	sleep 1
done

kill $psqlPid
wait

tar cf /volume/backup.tar /var/lib/postgresql

sync

