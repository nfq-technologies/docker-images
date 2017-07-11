#!/bin/bash

set +e

source /tools/functions_init.sh

run-parts -v /etc/rc.d


# default features
init_wait_for_a_dir
init_wait_for_a_not_empty_dir
init_wait_for_a_file
init_wait_for_a_not_empty_file
init_use_startup_trigger


init_wait_for_a_not_empty_file ${NFQ_SOLR_SCHEMA_PATH}
mv /etc/solr/conf/schema.xml{,.orig}
ln -s ${NFQ_SOLR_SCHEMA_PATH} /etc/solr/conf/schema.xml



cd /usr/share/jetty8
exec /usr/lib/jvm/default-java/bin/java \
	-Xmx256m \
	-Djava.awt.headless=true \
	-Djava.io.tmpdir=/tmp \
	-Djava.library.path=/usr/lib \
	-DSTART=/etc/jetty8/start.config \
	-Djetty.home=/usr/share/jetty8 \
	-Djetty.logs=/var/log/jetty8 \
	-Djetty.state=/var/lib/jetty8/jetty.state \
	-Djetty.host=0.0.0.0 \
	-Djetty.port=8983 \
	-cp /usr/share/java/commons-daemon.jar:/usr/share/jetty8/start.jar:/usr/lib/jvm/default-java/lib/tools.jar org.eclipse.jetty.start.Main \


