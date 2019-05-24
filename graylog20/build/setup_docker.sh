#!/bin/bash

set -x
set -e



apt-get update

apt-get install -y --no-install-recommends uuid-runtime jq

apt-get install -y --no-install-recommends -t jessie-backports openjdk-8-jre

apt-get install -y --no-install-recommends graylog-server


cp -frv /build/files/* /


source /usr/local/build_scripts/cleanup_apt.sh

