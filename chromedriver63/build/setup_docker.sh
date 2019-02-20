#!/bin/bash

set -x
set -e

apt-get update

apt-get install -y --no-install-recommends xvfb xauth chromedriver=57.0.2987.98-1~deb8u1


cp -frv /build/files/* /


source /usr/local/build_scripts/cleanup_apt.sh

