#!/bin/bash

set -x
set -e

wget -O /usr/local/bin/sentry-cli https://downloads.sentry-cdn.com/sentry-cli/1.49.0/sentry-cli-Linux-x86_64
chmod a+x /usr/local/bin/sentry-cli

# Clean up APT when done.
source /usr/local/build_scripts/cleanup_apt.sh

