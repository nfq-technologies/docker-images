#!/bin/bash

set -x
set -e

apt-get update

apt-get install -y --no-install-recommends rabbitmq-server

plugin_url="https://github.com/rabbitmq/rabbitmq-delayed-message-exchange/releases/download/v3.8.0/rabbitmq_delayed_message_exchange-3.8.0.ez"
save_path="/usr/lib/rabbitmq/lib/rabbitmq_server-3.7.8/plugins/rabbitmq_delayed_message_exchange-3.8.0.ez"
wget -O "$save_path" "$plugin_url"



cp -frv /build/files/* / || true

source /usr/local/build_scripts/cleanup_apt.sh

