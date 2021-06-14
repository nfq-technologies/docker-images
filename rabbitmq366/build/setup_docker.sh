#!/bin/bash

set -x
set -e

apt-get update

apt-get install -y --no-install-recommends rabbitmq-server

cp -frv /build/files/* / || true

source /usr/local/build_scripts/cleanup_apt.sh

