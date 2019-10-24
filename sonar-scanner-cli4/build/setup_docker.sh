#!/bin/bash

set -x
set -e

# Install dependencies
apt-get update
apt-get install -y --no-install-recommends openjdk-11-jre-headless

# Manually download and install
file="$(wget -qO - https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/ \
	| sed 's/href="\([^"]*\)">/\n\1\n/g' \
	| grep -i '^sonar.scanner.cli[-][0-9\.\-]*-linux\.zip$' \
	| sort --version-sort \
	| tail -n1)"

wget -qO sonar.zip https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/$file

unzip sonar.zip -d /usr/local/lib
ln -s /usr/local/lib/sonar-scanner-*/bin/sonar-scanner /usr/local/bin/sonar-scanner
ln -s /usr/local/bin/sonar-scanner /usr/bin/sonar-scanner

rm sonar.zip



# Copy runtime files
cp -frv /build/files/* / || true

# Clean up APT when done.
source /usr/local/build_scripts/cleanup_apt.sh

