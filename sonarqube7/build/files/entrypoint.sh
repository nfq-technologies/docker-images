#!/bin/bash

source /tools/functions_init.sh

run-parts -v /etc/rc.d

# default features
init_wait_for_a_dir
init_wait_for_a_not_empty_dir
init_wait_for_a_file
init_wait_for_a_not_empty_file
init_use_startup_trigger

# abandon all children, init proccess will take care of them on exit
trap 'exec true' EXIT


declare -a sq_opts

if [ -n "$SONARQUBE_JDBC_USERNAME" ]
then
	sq_opts+=("-Dsonar.jdbc.username=$SONARQUBE_JDBC_USERNAME")
fi
if [ -n "$SONARQUBE_JDBC_PASSWORD" ]
then
	sq_opts+=("-Dsonar.jdbc.password=$SONARQUBE_JDBC_PASSWORD")
fi
if [ -n "$SONARQUBE_JDBC_URL" ]
then
	sq_opts+=("-Dsonar.jdbc.url=$SONARQUBE_JDBC_URL")
fi

cd /home/project

tail -F /sonarqube/logs/es.log &

sleep 5

sudo -HEu project \
/usr/bin/java -jar ./sonarqube/lib/sonar-application-*.jar \
	-Dsonar.log.console=true \
	"${sq_opts[@]}" \
	&


wait


