#!/bin/bash

set -e
set -x

run-parts -v /etc/rc.d

exec supervisord -nc /etc/supervisor/supervisord.conf

