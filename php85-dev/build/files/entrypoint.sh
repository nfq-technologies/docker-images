#!/bin/bash

set -e

mkdir -p /var/run/sshd
chmod 0755 /var/run/sshd

/entrypoint-cli.sh

run-parts -v /etc/rc.d

exec /usr/sbin/sshd -D -e -f /etc/ssh/sshd_config

