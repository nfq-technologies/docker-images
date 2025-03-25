#!/bin/bash

set -e
set -x

if [ -z "$RABBITMQ_VERSION" ]; then
    echo "Error: QPDF_VERSION is not set."
    exit 1
fi

apt-get update -y

DEBIAN_FRONTEND=noninteractive apt-get install -y gnupg curl lsb-release debian-archive-keyring apt-transport-https

os=$(lsb_release -i | cut -f2 | awk '{ print tolower($1) }')
dist=$(lsb_release -c | cut -f2)

curl -sSf "https://packagecloud.io/install/repositories/cloudamqp/erlang/config_file.list?os=${os}&dist=${dist}&source=script" > /etc/apt/sources.list.d/cloudamqp_erlang.list

curl -fsSL "https://packagecloud.io/cloudamqp/erlang/gpgkey" | gpg --dearmor -o /etc/apt/keyrings/cloudamqp_erlang-archive-keyring.gpg

chmod 0644 "/etc/apt/keyrings/cloudamqp_erlang-archive-keyring.gpg"

apt-get update -y

apt-get install -y esl-erlang=1:26.0.1-1

wget "https://github.com/rabbitmq/rabbitmq-server/releases/download/v${RABBITMQ_VERSION}/rabbitmq-server_${RABBITMQ_VERSION}-1_all.deb" -O rabbitmq4.deb

apt-get install -y ./rabbitmq4.deb

rm -f ./rabbitmq4.deb

cp -frv /build/files/* / || true

source /usr/local/build_scripts/cleanup_apt.sh

