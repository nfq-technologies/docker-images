#!/bin/bash

set -x
set -e

# setup
apt-get update
apt-get install -y --no-install-recommends ca-certificates-java

ES_PKG_NAME=elasticsearch-7.16.3
arch="$([ "`uname -m`" = "aarch64" ] && echo "aarch64" || echo "x86_64")"

cd /tmp/
wget -nv -t5 -O es.tar.gz https://artifacts.elastic.co/downloads/elasticsearch/$ES_PKG_NAME-linux-$arch.tar.gz
tar xzf es.tar.gz
rm -f es.tar.gz
mv /tmp/$ES_PKG_NAME /elasticsearch
cd -


# elasticsearch plugins
es_plugin_install() {
    for i in {1..5}
    do
        /elasticsearch/bin/elasticsearch-plugin install $1 && break || sleep 1
    done
}
es_plugin_install analysis-icu


chown -R 1000:1000 /elasticsearch


cp -frv /build/files/* / || true

source /usr/local/build_scripts/cleanup_apt.sh


