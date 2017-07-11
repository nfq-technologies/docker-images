#!/bin/bash

set -e
set -x

run-parts -v /etc/rc.d

# start es
exec /elasticsearch/bin/elasticsearch

