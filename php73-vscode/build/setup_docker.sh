#!/bin/bash

set -x
set -e

echo force-unsafe-io > /etc/dpkg/dpkg.cfg.d/02apt-speedup


apt-get update


# vscode

wget -O /tmp/vscode.deb 'https://go.microsoft.com/fwlink/?LinkID=760868'
dpkg -i /tmp/vscode.deb || true
apt-get install -y --no-install-recommends --fix-broken

apt-get install -y --no-install-recommends \
	libx11-xcb1 \
	libxtst6 \
	libasound2 \
	x11-apps \
	xvfb \
	xauth \
	python-pip \
	python-wheel \
	python-setuptools \
	make \



# plugins
pip install virtualenv
sudo -HEu project code --force --install-extension bmewburn.vscode-intelephense-client
sudo -HEu project code --force --install-extension k--kato.intellij-idea-keybindings
sudo -HEu project code --force --install-extension nadim-vscode.symfony-code-snippets
sudo -HEu project code --force --install-extension ikappas.composer



sudo -HEu project xvfb-run code --verbose 2>&1 | tee /tmp/vscode &

timeout=60
while [ $timeout -gt 0 ]
do
	if grep -Fq 'update#setState checking for updates' </tmp/vscode
	then
		break
	else
		sleep 1
		((timeout--))
	fi
done
killall code || true



cp -frv /build/files/* / || true

chown -R 1000:1000 /home/project

source /usr/local/build_scripts/cleanup_apt.sh


