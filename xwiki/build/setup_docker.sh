#!/bin/bash

set -x
set -e

VERSION='8.4.1'

# Setup apt
apt-get update

# Java 8 + javamysql
apt-get install -y --no-install-recommends -t jessie-backports ca-certificates-java openjdk-8-jre-headless libmysql-java mysql-client

# unzip
apt-get install -y --no-install-recommends unzip

# XWiki
wget --quiet http://download.forge.ow2.org/xwiki/xwiki-enterprise-jetty-hsqldb-${VERSION}.zip -O /root/xwiki.zip
unzip /root/xwiki.zip -d /root
mv /root/xwiki-enterprise-jetty-hsqldb-${VERSION} /root/xwiki
rm -f /root/xwiki.zip

# LDAP support
wget --quiet "http://central.maven.org/maven2/com/novell/ldap/jldap/4.3/jldap-4.3.jar" \
	-O /root/xwiki/webapps/xwiki/WEB-INF/lib/jldap-4.3.jar

wget --quiet http://extensions.xwiki.org/xwiki/rest/repository/extensions/org.xwiki.contrib.ldap%3Aldap-authenticator/versions/9.1.2/file?rid=maven-xwiki \
	-O /root/xwiki/webapps/xwiki/WEB-INF/lib/org.xwiki.contrib.ldap_ldap-authenticator-9.1.2.jar

# MYSQL support
ln -s /usr/share/java/mysql.jar /root/xwiki/webapps/xwiki/WEB-INF/lib/mysql.jar


# Custom files
cp -frv /build/files/* / || true

# Cleanup
source /usr/local/build_scripts/cleanup_apt.sh

