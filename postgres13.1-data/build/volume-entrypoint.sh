#!/bin/bash
set -e

/docker-entrypoint.sh psql &
psqlPid=$!

while ! psql -U postgres -c "\l" &> /dev/null; do
	sleep 1
done

psql -U postgres -c "CREATE DATABASE project;"
psql -U postgres -c "CREATE USER 'project' WITH PASSWORD 'project' CREATEDB;"
psql -U postgres -c "GRANT CONNECT ON DATABASE project TO project;"

kill $psqlPid
wait

tar cf /volume/backup.tar /var/lib/postgresql

sync

