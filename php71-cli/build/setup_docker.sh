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
	php7.1-cli \
	php7.1-phpdbg \
	php7.1-bcmath \
	php7.1-bz2 \
	php7.1-curl \
	php7.1-dba \
	php7.1-enchant \
	php7.1-gd \
	php7.1-gmp \
	php7.1-imap \
	php7.1-interbase \
	php7.1-intl \
	php7.1-json \
	php7.1-ldap \
	php7.1-mbstring \
	php7.1-mcrypt \
	php7.1-mysql \
	php7.1-odbc \
	php7.1-opcache \
	php7.1-pgsql \
	php7.1-pspell \
	php7.1-readline \
	php7.1-recode \
	php7.1-snmp	 snmp \
	php7.1-soap \
	php7.1-sqlite3 \
	php7.1-sybase \
	php7.1-tidy \
	php7.1-xml \
	php7.1-xmlrpc \
	php7.1-xsl \
	php7.1-zip \
	php7.1-amqp \
	php7.1-apcu \
	php7.1-apcu-bc \
	php7.1-ast \
	php7.1-ds \
	php7.1-gearman \
	php7.1-geoip \
	php7.1-igbinary \
	php7.1-imagick	 libmagickcore-6.q16-3-extra \
	php7.1-mailparse \
	php7.1-memcache \
	php7.1-memcached \
	php7.1-mongodb \
	php7.1-msgpack \
	php7.1-oauth \
	php7.1-propro \
	php7.1-radius \
	php7.1-raphf \
	php7.1-redis \
	php7.1-rrd \
	php7.1-smbclient \
	php7.1-solr \
	php7.1-ssh2 \
	php7.1-stomp \
	php7.1-uploadprogress \
	php7.1-uuid \
	php7.1-yaml \
	php7.1-zmq \
	php7.1-xdebug \


# php7.1-embed - broke deb dependencies in 2017-03-06
# php-yac - conflicts with php-apcu
# php-gmagick - conflicts with php-imagick
# php-mongo - depends on php 5.6 api

# disable all php modules
ls -1 /etc/php/7.1/mods-available/ | sed 's/\.ini$//g' | xargs -I{} -n1 phpdismod -v ALL -s ALL {} 2>/dev/null
rm -rf /etc/php/{5.6,7.0,7.2,7.3,7.4}


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

