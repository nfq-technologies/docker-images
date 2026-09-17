#!/bin/bash
set -e
run-parts -v /etc/rc.d
exec sleep infinity
