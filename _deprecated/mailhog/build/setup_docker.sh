#!/bin/bash

set -x
set -e

arch="$([ "`uname -m`" = "aarch64" ] && echo "arm" || echo "amd64")"


apt-get update


apt-get install -y --no-install-recommends golang
wget -O /usr/local/bin/mailhog https://github.com/mailhog/MailHog/releases/download/v1.0.1/MailHog_linux_$arch
chmod a+x /usr/local/bin/mailhog


cp -frv /build/files/* /

source /usr/local/build_scripts/cleanup_apt.sh

