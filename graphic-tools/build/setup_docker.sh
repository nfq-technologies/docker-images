#!/bin/bash

set -x
set -e

# Install fontforge
apt-get update
apt-get install -y --no-install-recommends optipng pngquant pngcrush jpegoptim libjpeg-progs webp


# Copy runtime files
cp -frv /build/files/* / || true


# Clean up APT when done.
source /usr/local/build_scripts/cleanup_apt.sh

