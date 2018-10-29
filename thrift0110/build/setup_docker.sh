#!/bin/bash

set -x
set -e


apt-get update

# Installing build tools
apt-get install -y --no-install-recommends cmake g++ bison flex make

# Downloat thrift source
cd /tmp
wget https://www.apache.org/dist/thrift/0.11.0/thrift-0.11.0.tar.gz
tar -xzf thrift-0.11.0.tar.gz

# Build thrift compiler
cd thrift-0.11.0/build/cmake
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

