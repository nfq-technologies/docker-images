#!/bin/bash

set -e
set -x

run-parts -v /etc/rc.d

chown -R 1000:1000 /var/elasticsearch

# start es
exec su project -c /elasticsearch/bin/elasticsearch

