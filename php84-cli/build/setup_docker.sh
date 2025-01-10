#!/bin/bash

set -x
set -e

echo "deb [signed-by=/usr/share/keyrings/php-archive-keyring.gpg] https://packages.sury.org/php bookworm main" > /etc/apt/sources.list.d/sury.list
echo "deb-src [signed-by=/usr/share/keyrings/php-archive-keyring.gpg] https://packages.sury.org/php bookworm main" >> /etc/apt/sources.list.d/sury.list

wget --quiet -O /usr/share/keyrings/php-archive-keyring.gpg https://packages.sury.org/php/apt.gpg

cat >/etc/apt/preferences.d/sury <<EOF
Package: php8.4-*
Pin: origin packages.sury.org
Pin-Priority: 600
EOF

apt-get update
apt-get install -y --no-install-recommends \
	php8.4-amqp \
	php8.4-apcu \
	php8.4-ast \
	php8.4-bcmath \
	php8.4-bz2 \
	php8.4-cli \
	php8.4-common \
	php8.4-curl \
	php8.4-dba \
	php8.4-ds \
	php8.4-enchant \
	php8.4-gd \
	php8.4-gmp \
	php8.4-igbinary \
	php8.4-imagick libmagickcore-6.q16-6-extra \
	php8.4-imap \
	php8.4-interbase \
	php8.4-intl \
	php8.4-ldap \
	php8.4-mailparse \
	php8.4-mbstring \
	php8.4-memcache \
	php8.4-memcached \
	php8.4-mongodb \
	php8.4-msgpack \
	php8.4-mysql \
	php8.4-oauth \
	php8.4-odbc odbc-mdbtools \
	php8.4-opcache \
	php8.4-pcov \
	php8.4-pgsql \
	php8.4-phpdbg \
	php8.4-pspell \
	php8.4-psr \
	php8.4-raphf \
	php8.4-readline \
	php8.4-redis \
	php8.4-rrd \
	php8.4-smbclient \
	php8.4-snmp snmp \
	php8.4-soap \
	php8.4-sqlite3 \
	php8.4-ssh2 \
	php8.4-sybase \
	php8.4-tidy \
	php8.4-uuid \
	php8.4-xdebug \
	php8.4-xml \
	php8.4-xmlrpc \
	php8.4-xsl \
	php8.4-yaml \
	php8.4-zip \
	php8.4-zip \
	php8.4-zmq



# disable all php modules
ls -1 /etc/php/8.4/mods-available/ | sed 's/\.ini$//g' | xargs -I{} -n1 phpdismod -v ALL -s ALL {} 2>/dev/null

# cleanup older versions
rm -rf /etc/php/{5.6,7.0,7.1,7.2,7.3,7.4,8.0,8.1,8.2,8.3}

# backup original php.ini
mv /etc/php/8.4/cli/php.ini{,_orig}

# install dma (dragonfly mailer simple relay)
debconf-set-selections <<< "dma dma/mailname string"
debconf-set-selections <<< "dma dma/relayhost string mail"
apt-get install -y --no-install-recommends dma
echo '*: @' > /etc/aliases # force local mails to smarthost

# Copy build files
cp -frv /build/files/* / || true

# Clean up APT when done.
source /usr/local/build_scripts/cleanup_apt.sh
