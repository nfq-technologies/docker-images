#!/bin/bash

set -x
set -e

apt-get update
apt-get install -y --no-install-recommends openjdk-7-jre-headless


ES_PKG_NAME=elasticsearch-2.2.2
cd /tmp/
wget -nv -t5 -O es.tar.gz https://download.elasticsearch.org/elasticsearch/elasticsearch/$ES_PKG_NAME.tar.gz
tar xzf es.tar.gz
rm -f es.tar.gz
mv /tmp/$ES_PKG_NAME /elasticsearch
cd -

mkdir -p /data

# elasticsearch plugins
es_plugin_install() {
	for i in {1..5}
	do
		/elasticsearch/bin/plugin install $1 && break || sleep 1
	done
}
es_plugin_install mobz/elasticsearch-head
es_plugin_install analysis-icu
es_plugin_install lmenezes/elasticsearch-kopf/v2.1.1
es_plugin_install royrusso/elasticsearch-HQ/v2.0.3

# not supported yet
#/elasticsearch/bin/plugin install lukas-vlcek/bigdesk/2.4.0

cp -frv /build/files/* / || true

source /usr/local/build_scripts/cleanup_apt.sh


