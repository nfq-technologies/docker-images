#!/bin/bash

set -x
set -e

apt-get update

apt-get install -y --no-install-recommends rabbitmq-server

function install_plugin() {
		local plugin="$1"
		local URL="https://dl.bintray.com/rabbitmq/community-plugins/3.6.x/${plugin}/"
		local file="$(wget -O - $URL 2> /dev/null | grep "rabbitmq_delayed_message_exchange.*\.zip" | sed  's/^.*href="\([^"]*\.zip\).*$/\1/' | head -n1)"

		cd tmp
		wget -O plugin.zip "$URL/$file"
		unzip plugin.zip
		rm -rf plugin.zip
		mv ${plugin}* /usr/lib/rabbitmq/lib/rabbitmq_server-0.0.0/plugins/
		rm -f ${plugin}*
}

install_plugin rabbitmq_delayed_message_exchange

cp -frv /build/files/* / || true

source /usr/local/build_scripts/cleanup_apt.sh

