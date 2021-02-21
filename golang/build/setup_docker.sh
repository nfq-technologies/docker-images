#!/bin/bash

set -x
set -e

# Install golang
wget https://golang.org/dl/go1.16.linux-amd64.tar.gz
tar -C /usr/local -xzf go1.16.linux-amd64.tar.gz

cp -frv /build/files/* / || true

