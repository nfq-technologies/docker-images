#!/bin/bash

set -x
set -e

apt-get update

apt-get install -y --no-install-recommends \
	xvfb \
	xauth \
	chromium \
	chromium-driver \


cp -frv /build/files/* / || true

source /usr/local/build_scripts/cleanup_apt.sh

