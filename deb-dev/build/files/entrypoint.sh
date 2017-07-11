#!/bin/bash

set -e
source /tools/functions_init.sh


init_use_startup_trigger


run-parts -v /etc/rc.d


exec /usr/sbin/sshd -De

