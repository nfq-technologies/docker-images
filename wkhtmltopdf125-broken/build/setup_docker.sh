#!/bin/bash

set -x
set -e

# Install wkhtmltopdf dependencies
apt-get update
#apt-get install -y --no-install-recommends xvfb xauth  fontconfig libxrender1 xfonts-75dpi xfonts-base libjpeg-turbo8
apt-get install -y --no-install-recommends xvfb xauth  fontconfig libxrender1 xfonts-75dpi xfonts-base libjpeg62-turbo

# install more fonts
apt-get install -y --no-install-recommends fonts-liberation


cd /tmp
wget -O wk.deb https://github.com/wkhtmltopdf/wkhtmltopdf/releases/download/0.12.5/wkhtmltox_0.12.5-1.stretch_amd64.deb
dpkg -i wk.deb
ln -s ../local/bin/wkhtmltopdf /usr/bin/wkhtmltopdf


# Copy runtime files
cp -frv /build/files/* / || true


# Clean up APT when done.
source /usr/local/build_scripts/cleanup_apt.sh

