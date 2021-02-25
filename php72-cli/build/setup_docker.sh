#!/bin/bash

set -x
set -e

echo "deb https://packages.sury.org/php stretch main" > /etc/apt/sources.list.d/sury.list
echo "deb-src https://packages.sury.org/php stretch main" >> /etc/apt/sources.list.d/sury.list

wget --quiet https://packages.sury.org/php/apt.gpg
apt-key add apt.gpg
rm apt.gpg

cat >/etc/apt/preferences.d/sury <<EOF
Package: php-*
Pin: origin packages.sury.org
Pin-Priority: 600
EOF

apt-get update

apt-get install -y --no-install-recommends \
	php7.2-cli \
	php7.2-phpdbg \
	php7.2-bcmath \
	php7.2-bz2 \
	php7.2-curl \
	php7.2-dba \
	php7.2-enchant \
	php7.2-gd \
	php7.2-gmp \
	php7.2-imagick	 libmagickcore-6.q16-3-extra \
	php7.2-imap \
	php7.2-interbase \
	php7.2-intl \
	php7.2-json \
	php7.2-ldap \
	php7.2-mbstring \
	php7.2-mysql \
	php7.2-odbc \
	php7.2-opcache \
	php7.2-pgsql \
	php7.2-pspell \
	php7.2-readline \
	php7.2-recode \
	php7.2-snmp	 snmp \
	php7.2-soap \
	php7.2-sqlite3 \
	php7.2-sybase \
	php7.2-tidy \
	php7.2-xdebug \
	php7.2-xml \
	php7.2-xmlrpc \
	php7.2-xsl \
	php7.2-zip \
	php7.2-amqp \
	php7.2-apcu \
	php7.2-apcu-bc \
	php7.2-ds \
	php7.2-gearman \
	php7.2-geoip \
	php7.2-igbinary \
	php7.2-mailparse \
	php7.2-memcache \
	php7.2-memcached \
	php7.2-mongodb \
	php7.2-msgpack \
	php7.2-oauth \
	php7.2-propro \
	php7.2-radius \
	php7.2-raphf \
	php7.2-redis \
	php7.2-rrd \
	php7.2-smbclient \
	php7.2-solr \
	php7.2-ssh2 \
	php7.2-stomp \
	php7.2-uploadprogress \
	php7.2-uuid \
	php7.2-yaml \
	php7.2-zmq \

# php7.2-sodium - breaks php7.2-common
# php-ast - depends on php 7.1 api
# php-yac - conflicts with php-apcu
# php-gmagick - conflicts with php-imagick
# php-mongo - depends on php 5.6 api

# disable all php modules
ls -1 /etc/php/7.2/mods-available/ | sed 's/\.ini$//g' | xargs -I{} -n1 phpdismod -v ALL -s ALL {} 2>/dev/null

rm -rf /etc/php/{5.6,7.0,7.1,7.3,7.4}


# install custom php modules
apt-get install -y --no-install-recommends \
	nfq-php-tideways \
	phyaml \


# install dma (dragonfly mailer simple relay)
debconf-set-selections <<< "dma dma/mailname string"
debconf-set-selections <<< "dma dma/relayhost string mail"
apt-get install -y --no-install-recommends dma
echo '*: @' > /etc/aliases # force local mails to smarthost


cp -frv /build/files/* / || true


# Clean up APT when done.
source /usr/local/build_scripts/cleanup_apt.sh

