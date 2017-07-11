#!/bin/bash

set -x
set -e

apt-get update

# build env
apt-get install -y --no-install-recommends ruby ruby-dev build-essential


# gems
gem install bundler
gem install sass
gem install compass
gem install zurb-foundation

# Copy runtime files
cp -frv /build/files/* / || true

# Clean up APT when done.
source /usr/local/build_scripts/cleanup_apt.sh

