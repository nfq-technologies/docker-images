#!/bin/bash

set -x
set -e

cp -frv /build/files/* / || true


# Influxdb repository key
key="05CE15085FC09D18E99EFB22684A14CF2582E0C5"

gpg --keyserver ha.pool.sks-keyservers.net --recv-keys "$key" || \
gpg --keyserver pgp.mit.edu --recv-keys "$key" || \
gpg --keyserver keyserver.pgp.com --recv-keys "$key" ; \

# Version of influxdb to install
INFLUXDB_VERSION=1.8.5

wget --no-verbose https://dl.influxdata.com/influxdb/releases/influxdb_${INFLUXDB_VERSION}_amd64.deb.asc
wget --no-verbose https://dl.influxdata.com/influxdb/releases/influxdb_${INFLUXDB_VERSION}_amd64.deb

gpg --batch --verify influxdb_${INFLUXDB_VERSION}_amd64.deb.asc influxdb_${INFLUXDB_VERSION}_amd64.deb
dpkg --force-confdef -i influxdb_${INFLUXDB_VERSION}_amd64.deb
rm -f influxdb_${INFLUXDB_VERSION}_amd64.deb*

source /usr/local/build_scripts/cleanup_apt.sh

