#!/bin/bash

set -x
set -e

apt-get update

# Java 8
apt-get install -y --no-install-recommends ca-certificates-java openjdk-8-jdk-headless

source /usr/local/build_scripts/cleanup_apt.sh

