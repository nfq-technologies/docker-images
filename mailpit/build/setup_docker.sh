#!/bin/bash

set -x
set -e

arch="$([ "`uname -m`" = "aarch64" ] && echo "arm64" || echo "amd64")"


apt-get update

wget -O /tmp/mailpit.tar.gz https://github.com/axllent/mailpit/releases/latest/download/mailpit-linux-$arch.tar.gz
tar -xzf /tmp/mailpit.tar.gz -C /usr/local/bin mailpit
rm /tmp/mailpit.tar.gz
chmod a+x /usr/local/bin/mailpit

cp -frv /build/files/* /

source /usr/local/build_scripts/cleanup_apt.sh