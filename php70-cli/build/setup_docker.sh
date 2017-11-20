#!/bin/bash

set -x
set -e

apt-get update

apt-get install -y --no-install-recommends php7.0-cli \
	php7.0-apcu \
	php-apcu-bc \
	php7.0-bcmath \
	php7.0-bz2 \
	php7.0-curl \
	php7.0-dba \
	php7.0-enchant \
	php7.0-gd \
	php7.0-geoip \
	php7.0-gmp \
	php7.0-igbinary \
	php7.0-imagick  libmagickcore-6.q16-2-extra \
	php7.0-imap \
	php7.0-interbase \
	php7.0-intl \
	php7.0-json \
	php7.0-ldap \
	php7.0-mbstring \
	php7.0-mcrypt \
	php7.0-memcached \
	php7.0-mongodb \
	php7.0-msgpack \
	php7.0-mysql \
	php7.0-odbc odbc-mdbtools \
	php7.0-opcache \
	php7.0-pgsql \
	php7.0-pspell \
	php7.0-readline \
	php7.0-recode \
	php7.0-redis \
	php7.0-snmp     snmp \
	php7.0-soap \
	php7.0-ssh2 \
	php7.0-sqlite3 \
	php7.0-sybase \
	php7.0-tidy \
	php7.0-xdebug \
	php7.0-xml \
	php7.0-xmlrpc \
	php7.0-xsl \
	php7.0-zip \



# add missing odbc symlink
mkdir -p /usr/lib/x86_64-linux-gnu/odbc
ln -s /usr/lib/x86_64-linux-gnu/libodbccr.so.1 /usr/lib/x86_64-linux-gnu/odbc/libodbccr.so


# disable all php modules
ls -1 /etc/php/7.0/mods-available/ | sed 's/\.ini$//g' | xargs -I{} -n1 phpdismod -v ALL -s ALL {} 2>/dev/null


# install custom php modules
apt-get install -y --force-yes --no-install-recommends \
    nfq-php-tideways \


# install dma (dragonfly mailer simple relay)
debconf-set-selections <<< "dma dma/mailname string"
debconf-set-selections <<< "dma dma/relayhost string mail"
apt-get install -y --no-install-recommends dma
echo '*: @' > /etc/aliases # force local mails to smarthost


cp -frv /build/files/* / || true


# Clean up APT when done.
source /usr/local/build_scripts/cleanup_apt.sh

