#!/bin/bash
set -e

trap "echo Stopping ..." SIGTERM
run-parts -v /etc/rc.d

/root/xwiki/start_xwiki.sh -p 80 &
wait

