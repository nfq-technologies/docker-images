#!/bin/bash

set -x
set -e

#apt-get update

# Manulay downloading and install
file="https://packages.chef.io/files/stable/chefdk/1.2.22/ubuntu/16.04/chefdk_1.2.22-1_amd64.deb"

wget --no-check-certificate -O chefdk.deb $file
apt install ./chefdk.deb
rm chefdk.deb

# Generate locales
locale-gen "en_US.UTF-8"
dpkg-reconfigure locales
echo LC_ALL=en_US.UTF-8 > /etc/default/locale

cp -frv /build/files/* / || true

source /usr/local/build_scripts/cleanup_apt.sh

