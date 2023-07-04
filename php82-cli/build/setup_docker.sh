#!/bin/bash

set -x
set -e

echo "deb https://packages.sury.org/php bookworm main" > /etc/apt/sources.list.d/sury.list
echo "deb-src https://packages.sury.org/php bookworm main" >> /etc/apt/sources.list.d/sury.list

wget --quiet https://packages.sury.org/php/apt.gpg
apt-key add apt.gpg
rm apt.gpg

cat >/etc/apt/preferences.d/sury <<EOF
  Package: php8.2-*
  Pin: origin packages.sury.org
  Pin-Priority: 600
EOF


apt-get update

apt-get install -y --no-install-recommends \
        php8.2-amqp \
        php8.2-apcu \
        php8.2-ast \
        php8.2-bcmath \
        php8.2-bz2 \
        php8.2-cli \
        php8.2-common \
        php8.2-curl \
        php8.2-dba \
        php8.2-ds \
        php8.2-enchant \
        php8.2-gd \
        php8.2-gmp \
        php8.2-igbinary \
        php8.2-imagick libmagickcore-6.q16-6-extra \
        php8.2-imap \
        php8.2-interbase \
        php8.2-intl \
        php8.2-ldap \
        php8.2-mailparse \
        php8.2-mbstring \
        php8.2-memcache \
        php8.2-memcached \
        php8.2-mongodb \
        php8.2-msgpack \
        php8.2-mysql \
        php8.2-oauth \
        php8.2-odbc odbc-mdbtools \
        php8.2-opcache \
        php8.2-pcov \
        php8.2-pgsql \
        php8.2-phpdbg \
        php8.2-pspell \
        php8.2-psr \
        php8.2-raphf \
        php8.2-readline \
        php8.2-redis \
        php8.2-rrd \
        php8.2-smbclient \
        php8.2-snmp snmp \
        php8.2-soap \
        php8.2-sqlite3 \
        php8.2-ssh2 \
        php8.2-sybase \
        php8.2-solr \
        php8.2-tidy \
        php8.2-uuid \
        php8.2-xdebug \
        php8.2-xml \
        php8.2-xmlrpc \
        php8.2-xsl \
        php8.2-yaml \
        php8.2-zip \
        php8.2-zip \
        php8.2-zmq


# disable all php modules
ls -1 /etc/php/8.2/mods-available/ | sed 's/\.ini$//g' | xargs -I{} -n1 phpdismod -v ALL -s ALL {} 2>/dev/null

# cleanup older versions
rm -rf /etc/php/{5.6,7.0,7.1,7.2,7.3,7.4,8.0,8.1}

# backup original php.ini
mv /etc/php/8.2/cli/php.ini{,_orig}

# install dma (dragonfly mailer simple relay)
debconf-set-selections <<< "dma dma/mailname string"
debconf-set-selections <<< "dma dma/relayhost string mail"
apt-get install -y --no-install-recommends dma
echo '*: @' > /etc/aliases # force local mails to smarthost

# Copy build files
cp -frv /build/files/* / || true

# Clean up APT when done.
source /usr/local/build_scripts/cleanup_apt.sh
