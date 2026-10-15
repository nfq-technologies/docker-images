#!/bin/bash

set -x
set -e

# Install wkhtmltopdf and xvfb frame buffer
apt-get update
apt-get install -y --no-install-recommends xvfb xauth
apt-get install -y --no-install-recommends wkhtmltopdf

# install more fonts
apt-get install -y --no-install-recommends fonts-liberation


# Copy runtime files
cp -frv /build/files/* / || true


# Clean up APT when done.
source /usr/local/build_scripts/cleanup_apt.sh

