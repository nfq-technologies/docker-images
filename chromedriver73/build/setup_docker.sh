#!/bin/bash

set -x
set -e

apt-get update

apt-get install -y --no-install-recommends \
	xvfb \
	xauth \
	chromium=73.0.3683.75-1~deb9u1 \
	chromium-driver=73.0.3683.75-1~deb9u1 \
	chromedriver=73.0.3683.75-1~deb9u1 \


cp -frv /build/files/* / || true

source /usr/local/build_scripts/cleanup_apt.sh

