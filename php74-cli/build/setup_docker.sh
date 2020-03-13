#!/bin/bash

set -x
set -e

echo "deb https://packages.sury.org/php buster main" > /etc/apt/sources.list.d/sury.list
echo "deb-src https://packages.sury.org/php buster main" >> /etc/apt/sources.list.d/sury.list

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
	php7.4-zip \
	php-amqp \
	php-apcu \
	php-apcu-bc \
	php-ast \
	php-ds \
	php-gearman \
	php-geoip \
	php-igbinary \
	php-imagick libmagickcore-6.q16-6-extra \
	php-lua \
	php-mailparse \
	php-memcache \
	php-memcached \
	php-mongodb \
	php-msgpack \
	php-oauth \
	php-pcov \
	php-propro \
	php-psr \
	php-radius \
	php-raphf \
	php-redis \
	php-rrd \
	php-smbclient \
	php-solr \
	php-ssh2 \
	php-stomp \
	php-uopz \
	php-uploadprogress \
	php-uuid \
	php-yaml \
	php-zmq \
	php-xdebug \



#	php-gmagick \ provides more stable api but conflicts with imagick
#	php-yac \ conflicts with php-apcu
#	php-tideways \ conflicts with nfq-php-tideways
# 	php-sodium \ Only for 7.0 and 7.1 From 7.2 should be built in

# disable all php modules
ls -1 /etc/php/7.4/mods-available/ | sed 's/\.ini$//g' | xargs -I{} -n1 phpdismod -v ALL -s ALL {} 2>/dev/null

# cleanup older versions
 rm -rf /etc/php/{5.6,7.0,7.1,7.2,7.3}

# backup original php.ini
mv /etc/php/7.4/cli/php.ini{,_orig}


# install custom php modules
apt-get install -y --no-install-recommends \
    phyaml \
    nfq-php-tideways


# install dma (dragonfly mailer simple relay)
debconf-set-selections <<< "dma dma/mailname string"
debconf-set-selections <<< "dma dma/relayhost string mail"
apt-get install -y --no-install-recommends dma
echo '*: @' > /etc/aliases # force local mails to smarthost



cp -frv /build/files/* / || true

# Clean up APT when done.
source /usr/local/build_scripts/cleanup_apt.sh

