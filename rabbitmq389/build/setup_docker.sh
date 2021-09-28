#!/bin/bash

set -x
set -e

apt-get update

apt-get install -y --no-install-recommends rabbitmq-server

plugin_url="https://github.com/rabbitmq/rabbitmq-delayed-message-exchange/releases/download/3.8.9/rabbitmq_delayed_message_exchange-3.8.9-0199d11c.ez"
save_path="/usr/lib/rabbitmq/lib/rabbitmq_server-3.8.9/plugins/rabbitmq_delayed_message_exchange-3.8.9-0199d11c.ez"
wget -O "$save_path" "$plugin_url"



cp -frv /build/files/* / || true

source /usr/local/build_scripts/cleanup_apt.sh

