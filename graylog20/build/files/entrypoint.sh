#!/bin/bash

set +e

source /tools/functions_init.sh

date | tr -d "\n" ; echo "++ Waiting for required services to start ... "
init_wait_for_connection graymongo:27017 300
init_wait_for_connection grayelastic:9200 300

date | tr -d "\n" ; echo "++ Required services started. proceeding with run-parts"

run-parts /etc/rc.d

if [ ! -z "$NFQ_GRAYLOG_API_HOST" ]
then
	sed -ri.orig 's~^rest_transport_uri.*$~rest_transport_uri = http://'$NFQ_GRAYLOG_API_HOST':12900/~' /etc/graylog/server/server.conf
fi

export GRAYLOG_SERVER_JAVA_OPTS="-Dlog4j2.formatMsgNoLookups=true"
exec /usr/share/graylog-server/bin/graylog-server

