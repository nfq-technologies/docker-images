#!/bin/bash

set -x
set -e

echo "deb [signed-by=/usr/share/keyrings/php-archive-keyring.gpg] https://packages.sury.org/php trixie main" > /etc/apt/sources.list.d/sury.list
echo "deb-src [signed-by=/usr/share/keyrings/php-archive-keyring.gpg] https://packages.sury.org/php trixie main" >> /etc/apt/sources.list.d/sury.list

wget --quiet -O /usr/share/keyrings/php-archive-keyring.gpg https://packages.sury.org/php/apt.gpg

cat >/etc/apt/preferences.d/sury <<EOF
Package: php8.5-*
Pin: origin packages.sury.org
Pin-Priority: 600
EOF

apt-get update
apt-get install -y --no-install-recommends \
	php8.5-amqp \
	php8.5-apcu \
	php8.5-ast \
	php8.5-bcmath \
	php8.5-bz2 \
	php8.5-cli \
	php8.5-common \
	php8.5-curl \
	php8.5-dba \
	php8.5-ds \
	php8.5-enchant \
	php8.5-gd \
	php8.5-gmp \
	php8.5-igbinary \
	php8.5-imagick libmagickcore-6.q16-6-extra \
	php8.5-imap \
	php8.5-interbase \
	php8.5-intl \
	php8.5-ldap \
	php8.5-mailparse \
	php8.5-mbstring \
	php8.5-memcache \
	php8.5-memcached \
	php8.5-mongodb \
	php8.5-msgpack \
	php8.5-mysql \
	php8.5-oauth \
	php8.5-odbc odbc-mdbtools \
	php8.5-opcache \
	php8.5-pcov \
	php8.5-pgsql \
	php8.5-phpdbg \
	php8.5-pspell \
	php8.5-psr \
	php8.5-raphf \
	php8.5-readline \
	php8.5-redis \
	php8.5-rrd \
	php8.5-smbclient \
	php8.5-snmp snmp \
	php8.5-soap \
	php8.5-sqlite3 \
	php8.5-ssh2 \
	php8.5-sybase \
	php8.5-tidy \
	php8.5-uuid \
	php8.5-xdebug \
	php8.5-xml \
	php8.5-xmlrpc \
	php8.5-xsl \
	php8.5-yaml \
	php8.5-zip \
	php8.5-zip \
	php8.5-zmq



# disable all php modules
ls -1 /etc/php/8.5/mods-available/ | sed 's/\.ini$//g' | xargs -I{} -n1 phpdismod -v ALL -s ALL {} 2>/dev/null

# cleanup older versions
rm -rf /etc/php/{5.6,7.0,7.1,7.2,7.3,7.4,8.0,8.1,8.2,8.3,8.4}

# backup original php.ini
mv /etc/php/8.5/cli/php.ini{,_orig}

# install dma (dragonfly mailer simple relay)
debconf-set-selections <<< "dma dma/mailname string"
debconf-set-selections <<< "dma dma/relayhost string mail"
apt-get install -y --no-install-recommends dma
echo '*: @' > /etc/aliases # force local mails to smarthost

# Copy build files
cp -frv /build/files/* / || true

# Clean up APT when done.
source /usr/local/build_scripts/cleanup_apt.sh
