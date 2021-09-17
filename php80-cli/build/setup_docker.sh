#!/bin/bash

set -x
set -e

echo "deb https://packages.sury.org/php bullseye main" > /etc/apt/sources.list.d/sury.list
echo "deb-src https://packages.sury.org/php bullseye main" >> /etc/apt/sources.list.d/sury.list

wget --quiet https://packages.sury.org/php/apt.gpg
apt-key add apt.gpg
rm apt.gpg

cat >/etc/apt/preferences.d/sury <<EOF
  Package: php8.0-*
  Pin: origin packages.sury.org
  Pin-Priority: 600
EOF


apt-get update

apt-get install -y --no-install-recommends \
	php8.0-cli \
	php8.0-phpdbg \
	php8.0-bcmath \
	php8.0-bz2 \
	php8.0-common \
	php8.0-curl \
	php8.0-dba \
	php8.0-enchant \
	php8.0-gd \
	php8.0-gmp \
	php8.0-imagick libmagickcore-6.q16-6-extra \
	php8.0-imap \
	php8.0-interbase \
	php8.0-intl \
	php8.0-ldap \
	php8.0-mbstring \
	php8.0-mysql \
	php8.0-odbc		odbc-mdbtools \
	php8.0-opcache \
	php8.0-pgsql \
	php8.0-pspell \
	php8.0-readline \
	php8.0-snmp		snmp \
	php8.0-soap \
	php8.0-sqlite3 \
	php8.0-sybase \
	php8.0-tidy \
	php8.0-xml \
	php8.0-xmlrpc \
	php8.0-xsl \
	php8.0-xdebug \
	php8.0-zip \
	php8.0-amqp \
	php8.0-apcu \
	php8.0-ast \
	php8.0-ds \
	php8.0-gearman \
	php8.0-igbinary \
	php8.0-mailparse \
	php8.0-memcache \
	php8.0-memcached \
	php8.0-mongodb \
	php8.0-msgpack \
	php8.0-oauth \
	php8.0-pcov \
	php8.0-psr \
	php8.0-raphf \
	php8.0-redis \
	php8.0-rrd \
	php8.0-smbclient \
	php8.0-solr \
	php8.0-ssh2 \
	php8.0-uuid \
	php8.0-yaml \
	php8.0-zmq \
	php8.0-xdebug \



# disable all php modules
ls -1 /etc/php/8.0/mods-available/ | sed 's/\.ini$//g' | xargs -I{} -n1 phpdismod -v ALL -s ALL {} 2>/dev/null

# cleanup older versions
rm -rf /etc/php/{5.6,7.0,7.1,7.2,7.3,7.4}

# backup original php.ini
mv /etc/php/8.0/cli/php.ini{,_orig}


# install custom php modules
apt-get install -y --no-install-recommends \
	nfq-php-tideways \
	phyaml

# install dma (dragonfly mailer simple relay)
debconf-set-selections <<< "dma dma/mailname string"
debconf-set-selections <<< "dma dma/relayhost string mail"
apt-get install -y --no-install-recommends dma
echo '*: @' > /etc/aliases # force local mails to smarthost



cp -frv /build/files/* / || true

# Clean up APT when done.
source /usr/local/build_scripts/cleanup_apt.sh

