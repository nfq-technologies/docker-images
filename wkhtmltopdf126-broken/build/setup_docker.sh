#!/bin/bash

set -x
set -e

arch="$([ "`uname -m`" = "aarch64" ] && echo "arm64" || echo "amd64")"

# Install wkhtmltopdf dependencies
apt-get update
#apt-get install -y --no-install-recommends xvfb xauth  fontconfig libxrender1 xfonts-75dpi xfonts-base libjpeg-turbo8
apt-get install -y --no-install-recommends xvfb xauth  fontconfig libxrender1 xfonts-75dpi xfonts-base libjpeg62-turbo

# install more fonts
apt-get install -y --no-install-recommends fonts-liberation


cd /tmp
wget -O wk.deb https://github.com/wkhtmltopdf/packaging/releases/download/0.12.6.1-2/wkhtmltox_0.12.6.1-2.bullseye_$arch.deb
dpkg -i wk.deb
ln -s ../local/bin/wkhtmltopdf /usr/bin/wkhtmltopdf


# Copy runtime files
cp -frv /build/files/* / || true


# Clean up APT when done.
source /usr/local/build_scripts/cleanup_apt.sh

