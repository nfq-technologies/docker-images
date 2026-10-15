#!/bin/bash

set -x
set -e

apt-get update

apt-get install -y chrpath libfreetype6 libfontconfig1
cd /tmp
wget -O - https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-1.9.8-linux-x86_64.tar.bz2 | tar xvj
mv phantomjs* /usr/local/share
ln -sf /usr/local/share/phantomjs*/bin/phantomjs /usr/local/bin
cd -


cp -frv /build/files/* /


source /usr/local/build_scripts/cleanup_apt.sh

