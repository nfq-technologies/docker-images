#!/bin/bash

set -x
set -e

apt-get update
apt-get install -y --no-install-recommends cron busybox-syslogd

echo > /etc/crontab
rm -fr /etc/cron.d
mkdir /etc/cron.d


cp -frv /build/files/* /


# Clean up APT when done.
source /usr/local/build_scripts/cleanup_apt.sh

