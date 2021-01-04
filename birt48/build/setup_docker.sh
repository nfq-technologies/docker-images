#!/bin/bash

set -x
set -e

apt-get update

# Java 8
apt-get install -y --no-install-recommends ca-certificates-java openjdk-8-jre-headless

# Tomcat 8
apt-get install -y --no-install-recommends tomcat8

# Birt manual war
mkdir -p /tmp/birt
wget https://ftp.halifax.rwth-aachen.de/eclipse/birt/downloads/drops/R-R1-4.8.0-201806261756/birt-runtime-4.8.0-20180626.zip -O /tmp/birt/birt.zip
cd /tmp/birt
unzip birt.zip
mv birt.war /var/lib/tomcat8/webapps
cd /
rm -rf /tmp/birt

# Cleanup tomcat
rm -rf /var/lib/tomcat8/webapps/ROOT

# Run tomcat to deploy birt war
/build/files/entrypoint.sh &>/dev/null &

tomcat_pid=$!

set +x
echo -n "Waiting for birt deployment ."
while [[ ! -f /var/lib/tomcat8/webapps/birt/WEB-INF/web.xml ]]; do
		sleep 0.7
		echo -n "."
done
echo -ne "\nDone\n"
set -x

kill $tomcat_pid
rm /var/lib/tomcat8/webapps/birt.war

# Copy runtime files
cp -frv /build/files/* / || true

source /usr/local/build_scripts/cleanup_apt.sh

