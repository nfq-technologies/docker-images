#!/bin/bash

set -ex

apt-get update

wget https://packagecloud.io/rabbitmq/rabbitmq-server/packages/debian/bullseye/rabbitmq-server_3.8.35-1_all.deb/download.deb

apt -y install erlang-base erlang-crypto erlang-eldap erlang-inets erlang-mnesia erlang-os-mon erlang-parsetools erlang-public-key erlang-runtime-tools erlang-ssl erlang-syntax-tools erlang-tools erlang-xmerl ./download.deb

rm ./download.deb

cp -frv /build/files/* / || true

source /usr/local/build_scripts/cleanup_apt.sh

