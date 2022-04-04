#!/bin/bash

set -x
set -e

#install python3-pip
apt-get update
apt-get install -y python3-pip


#cleanup
source /usr/local/build_scripts/cleanup_apt.sh

