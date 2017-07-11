#!/bin/bash

set -x
set -e

# Setup apt
echo "deb http://ftp.debian.org/debian jessie-backports main" > /etc/apt/sources.list.d/backports.list
apt-get update

# Java 8
apt-get install -y --no-install-recommends -t jessie-backports ca-certificates-java openjdk-8-jre-headless 

source /usr/local/build_scripts/cleanup_apt.sh

