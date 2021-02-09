#!/bin/bash
set -e

/docker-entrypoint.sh postgres &
psqlPid=$!

while ! PGPASSWORD=postgres psql -h localhost -U postgres -c "\c project"; do
	sleep 1
done

#psql -h localhost -U postgres -c "CREATE DATABASE project;"
psql -h localhost -U postgres -c "CREATE USER project WITH PASSWORD 'project' CREATEDB;"
psql -h localhost -U postgres -c "GRANT ALL ON DATABASE project TO project;"

kill $psqlPid
wait

tar cf /volume/backup.tar /var/lib/postgresql

sync

