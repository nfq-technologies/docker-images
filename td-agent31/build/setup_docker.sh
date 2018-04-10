#!/bin/bash

set -x
set -e



apt-get update
apt-get install -y --no-install-recommends jq


curl https://toolbelt.treasuredata.com/sh/install-debian-stretch-td-agent2.sh | bash


cp -frv /build/files/* /


source /usr/local/build_scripts/cleanup_apt.sh

