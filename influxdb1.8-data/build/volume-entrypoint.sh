#!/bin/bash
set -e

/entrypoint.sh influxd &
influxPid=$!

while ! influx -execute "show databases"; do
	sleep 2
done

influx -execute "CREATE USER project WITH PASSWORD 'project' WITH ALL PRIVILEGES"
influx -execute "CREATE DATABASE project"

kill $influxPid
wait

tar cf /volume/backup.tar /var/lib/influxdb

sync

