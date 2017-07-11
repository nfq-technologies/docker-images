#!/bin/bash

set -x
set -e

apt-get update

apt-get install -y --no-install-recommends solr-jetty


cp -frv /build/files/* /


source /usr/local/build_scripts/cleanup_apt.sh

