#!/bin/bash
set -e

exec /usr/lib/jvm/java-8-openjdk-amd64/bin/java \
	-Djava.awt.headless=true \
	-XX:+UseConcMarkSweepGC \
	-Djdk.tls.ephemeralDHKeySize=2048 \
	-Djava.protocol.handler.pkgs=org.apache.catalina.webresources \
	-classpath /usr/share/tomcat8/bin/bootstrap.jar:/usr/share/tomcat8/bin/tomcat-juli.jar \
	-Dcatalina.base=/var/lib/tomcat8 \
	-Dcatalina.home=/usr/share/tomcat8 \
	-Djava.io.tmpdir=/tmp/tomcat8-tomcat8-tmp \
	org.apache.catalina.startup.Bootstrap \
	start

