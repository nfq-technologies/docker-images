#!/bin/bash

set -xe

if [ -z "$QPDF_VERSION" ]; then
    echo "Error: QPDF_VERSION is not set."
    exit 1
fi

# Update package lists and install dependencies
apt-get update && \
apt-get install -y --no-install-recommends \
    wget \
    unzip

# Download and extract qpdf source code
cd /build && \
wget "https://github.com/qpdf/qpdf/releases/download/v$QPDF_VERSION/qpdf-$QPDF_VERSION-bin-linux-x86_64.zip" -O /build/qpdf.zip && \
unzip /build/qpdf.zip -d /usr/local/

# Copy runtime files
cp -frv /build/files/* / || true

# Clean up APT when done.
source /usr/local/build_scripts/cleanup_apt.sh

