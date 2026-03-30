#!/bin/bash

set -x
set -e

arch="$([ "`uname -m`" = "aarch64" ] && echo "aarch64" || echo "x86_64")"

# Add kubectl repository
curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.32/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
chmod 644 /etc/apt/keyrings/kubernetes-apt-keyring.gpg # allow unprivileged APT programs to read this keyring

# This overwrites any existing configuration in /etc/apt/sources.list.d/kubernetes.list
echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.32/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list
sudo chmod 644 /etc/apt/sources.list.d/kubernetes.list

# Update apt repos
apt-get update

# Install Docker CE CLI from official Docker repo (API 1.44+)
apt-get install --no-install-recommends -y ca-certificates curl
install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
chmod a+r /etc/apt/keyrings/docker.asc
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian bookworm stable" > /etc/apt/sources.list.d/docker.list
apt-get update
apt-get install --no-install-recommends -y docker-ce-cli docker-compose-plugin

# Add compatibility symlink for old docker-compose calls
ln -s /usr/libexec/docker/cli-plugins/docker-compose /usr/local/bin/docker-compose

# Install python and other tools
apt-get install --no-install-recommends -y python3-venv make kubectl

# Creating and activating virtual environment
python3 -m venv /python; source /python/bin/activate

# Install installer dependencies
pip install -U pip

# The actual install
pip install PyYAML==5.3.1 awsebcli

# Install awscli v2
curl "https://awscli.amazonaws.com/awscli-exe-linux-$arch.zip" -o "awscliv2.zip"
unzip awscliv2.zip
./aws/install
rm -rf awscliv2.zip ./aws

# Install azure cli
curl -sL https://aka.ms/InstallAzureCLIDeb | bash

# Chown project home to project
chown -R project:project /home/project

# Clean up APT when done.
source /usr/local/build_scripts/cleanup_apt.sh

