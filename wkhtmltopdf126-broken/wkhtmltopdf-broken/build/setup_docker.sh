#!/bin/bash

set -x
set -e

# Install wkhtmltopdf dependencies
apt-get update
apt-get install -y --no-install-recommends xvfb  libxrender1 libfontconfig1 libxext6 libssl1.0
#FIXME:  wkhtmltopdf depends on legacy libssl so we are removing new one
apt-get remove -y libssl1.1


cd /tmp
wget -O wk.txz https://github.com/wkhtmltopdf/wkhtmltopdf/releases/download/0.12.4/wkhtmltox-0.12.4_linux-generic-amd64.tar.xz
tar xf wk.txz
cp -r wkhtmltox/* /usr/

# Copy runtime files
cp -frv /build/files/* / || true


# Clean up APT when done.
source /usr/local/build_scripts/cleanup_apt.sh

