#!/bin/bash

set -x
set -e


apt-get update

# Installing build tools
apt-get install -y --no-install-recommends cmake g++ bison flex make

# Downloat thrift source
cd /tmp
wget https://github.com/apache/thrift/archive/refs/tags/0.9.3.1.tar.gz
tar -xzf 0.9.3.1.tar.gz

# Build thrift compiler
cd thrift-0.9.3.1/build/cmake
cmake ../../
make
make install 
ln -s /usr/local/bin/thrift /usr/bin/thrift

# Clean up build tools
apt-get purge -y cmake g++ bison flex make
apt-get autoremove -y

# Copy runtime files
cp -frv /build/files/* / || true

# Clean up APT when done.
source /usr/local/build_scripts/cleanup_apt.sh

