#!/bin/bash

set -x
set -e

apt-get update

apt-get install -y --no-install-recommends \
	php7.4-cli \
	php7.4-phpdbg \
	php7.4-bcmath \
	php7.4-bz2 \
	php7.4-common \
	php7.4-curl \
	php7.4-dba \
	php7.4-enchant \
	php7.4-gd \
	php7.4-gmp \
	php7.4-imagick libmagickcore-6.q16-6-extra \
	php7.4-imap \
	php7.4-interbase \
	php7.4-intl \
	php7.4-json \
	php7.4-ldap \
	php7.4-mbstring \
	php7.4-mysql \
	php7.4-odbc		odbc-mdbtools \
	php7.4-opcache \
	php7.4-pgsql \
	php7.4-pspell \
	php7.4-readline \
	php7.4-snmp		snmp \
	php7.4-soap \
	php7.4-sqlite3 \
	php7.4-sybase \
	php7.4-tidy \
	php7.4-xml \
	php7.4-xmlrpc \
	php7.4-xsl \
	php7.4-xdebug \
	php7.4-zip \
	php7.4-amqp \
	php7.4-apcu \
	php7.4-apcu-bc \
	php7.4-ast \
	php7.4-ds \
	php7.4-gearman \
	php7.4-geoip \
	php7.4-igbinary \
	php7.4-lua \
	php7.4-mailparse \
	php7.4-memcache \
	php7.4-memcached \
	php7.4-mongodb \
	php7.4-msgpack \
	php7.4-oauth \
	php7.4-pcov \
	php7.4-propro \
	php7.4-psr \
	php7.4-radius \
	php7.4-raphf \
	php7.4-redis \
	php7.4-rrd \
	php7.4-solr \
	php7.4-ssh2 \
	php7.4-stomp \
	php7.4-uopz \
	php7.4-uploadprogress \
	php7.4-uuid \
	php7.4-yaml \
	php7.4-zmq \
	php7.4-xdebug \
	libgv-php7 \

#	php7.4-gmagick \ provides more stable api but conflicts with imagick
#	php7.4-yac \ conflicts with php7.4-apcu
#	php7.4-tideways \ conflicts with nfq-php7.4-tideways
# 	php7.4-sodium \ Only for 7.0 and 7.1 From 7.2 should be built in

# disable all php modules
ls -1 /etc/php/7.4/mods-available/ | sed 's/\.ini$//g' | xargs -I{} -n1 phpdismod -v ALL -s ALL {} 2>/dev/null

# cleanup older versions
 rm -rf /etc/php/{5.6,7.0,7.1,7.2,7.3}

# backup original php.ini
mv /etc/php/7.4/cli/php.ini{,_orig}

# install dma (dragonfly mailer simple relay)
debconf-set-selections <<< "dma dma/mailname string"
debconf-set-selections <<< "dma dma/relayhost string mail"
apt-get install -y --no-install-recommends dma
echo '*: @' > /etc/aliases # force local mails to smarthost

cp -frv /build/files/* / || true

# Clean up APT when done.
source /usr/local/build_scripts/cleanup_apt.sh

