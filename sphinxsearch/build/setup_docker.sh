#!/bin/bash

set -x
set -e

apt-get update

# installing/configuring sphinx
wget -O /tmp/sphinx.deb "http://sphinxsearch.com/files/sphinxsearch_2.2.11-release-1~jessie_amd64.deb"
dpkg -i /tmp/sphinx.deb || true
apt-get install -yf
rm      /tmp/sphinx.deb


cp -frv /build/files/* /


source /usr/local/build_scripts/cleanup_apt.sh

