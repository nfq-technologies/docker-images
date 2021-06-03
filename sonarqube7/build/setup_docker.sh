#!/bin/bash

set -x
set -e

# Install dependencies
apt-get update
apt-get install -y --no-install-recommends openjdk-11-jre-headless

# Manually download and install
file="$(wget -qO - https://binaries.sonarsource.com/Distribution/sonarqube/ \
	| sed 's/href="\([^"]*\)">/\n\1\n/g' \
	| grep -i '^sonarqube[-]7[.][0-9\.\-]*\.zip$' \
	| sort --version-sort \
	| tail -n1)"

cd /home/project

wget -qO sonar.zip https://binaries.sonarsource.com/Distribution/sonarqube/$file
unzip -q sonar.zip
rm sonar.zip

mv sonarqube{-*,}
chown -R project:project sonarqube



# Copy runtime files
cp -frv /build/files/* / || true

# Clean up APT when done.
source /usr/local/build_scripts/cleanup_apt.sh

