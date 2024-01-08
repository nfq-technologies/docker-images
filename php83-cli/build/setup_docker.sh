#!/bin/bash

set -x
set -e

echo "deb https://packages.sury.org/php bookworm main" > /etc/apt/sources.list.d/sury.list
echo "deb-src https://packages.sury.org/php bookworm main" >> /etc/apt/sources.list.d/sury.list

wget --quiet https://packages.sury.org/php/apt.gpg
apt-key add apt.gpg
rm apt.gpg

cat >/etc/apt/preferences.d/sury <<EOF
	Package: php8.3-*
	Pin: origin packages.sury.org
	Pin-Priority: 600
EOF


apt-get update
apt-get install -y --no-install-recommends \
	php8.3-amqp \
	php8.3-apcu \
	php8.3-ast \
	php8.3-bcmath \
	php8.3-bz2 \
	php8.3-cli \
	php8.3-common \
	php8.3-curl \
	php8.3-dba \
	php8.3-ds \
	php8.3-enchant \
	php8.3-gd \
	php8.3-gmp \
	php8.3-igbinary \
	php8.3-imagick libmagickcore-6.q16-6-extra \
	php8.3-imap \
	php8.3-interbase \
	php8.3-intl \
	php8.3-ldap \
	php8.3-mailparse \
	php8.3-mbstring \
	php8.3-memcache \
	php8.3-memcached \
	php8.3-mongodb \
	php8.3-msgpack \
	php8.3-mysql \
	php8.3-oauth \
	php8.3-odbc odbc-mdbtools \
	php8.3-opcache \
	php8.3-pcov \
	php8.3-pgsql \
	php8.3-phpdbg \
	php8.3-pspell \
	php8.3-psr \
	php8.3-raphf \
	php8.3-readline \
	php8.3-redis \
	php8.3-rrd \
	php8.3-smbclient \
	php8.3-snmp snmp \
	php8.3-soap \
	php8.3-sqlite3 \
	php8.3-ssh2 \
	php8.3-sybase \
	php8.3-solr \
	php8.3-tidy \
	php8.3-uuid \
	php8.3-xdebug \
	php8.3-xml \
	php8.3-xmlrpc \
	php8.3-xsl \
	php8.3-yaml \
	php8.3-zip \
	php8.3-zip \
	php8.3-zmq



# disable all php modules
ls -1 /etc/php/8.3/mods-available/ | sed 's/\.ini$//g' | xargs -I{} -n1 phpdismod -v ALL -s ALL {} 2>/dev/null

# cleanup older versions
rm -rf /etc/php/{5.6,7.0,7.1,7.2,7.3,7.4,8.0,8.1,8.2}

# backup original php.ini
mv /etc/php/8.3/cli/php.ini{,_orig}

# install dma (dragonfly mailer simple relay)
debconf-set-selections <<< "dma dma/mailname string"
debconf-set-selections <<< "dma dma/relayhost string mail"
apt-get install -y --no-install-recommends dma
echo '*: @' > /etc/aliases # force local mails to smarthost

# Copy build files
cp -frv /build/files/* / || true

# Clean up APT when done.
source /usr/local/build_scripts/cleanup_apt.sh
