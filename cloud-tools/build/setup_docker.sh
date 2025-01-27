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

# Install python
apt-get install --no-install-recommends -y python3-venv docker.io docker-compose make kubectl

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

# Copy runtime files
cp -frv /build/files/* / || true

# Install azure cli
curl -sL https://aka.ms/InstallAzureCLIDeb | bash


# Chown project home to project
chown -R project:project /home/project


# Copy runtime files
cp -frv /build/files/* / || true

# Clean up APT when done.
source /usr/local/build_scripts/cleanup_apt.sh


