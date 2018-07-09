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

apt-get install -y --no-install-recommends php7.2-cli \
    php7.2-bcmath \
    php7.2-bz2 \
    php7.2-curl \
    php7.2-dba \
    php7.2-enchant \
    php7.2-gd \
    php7.2-gmp \
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
    php7.2-snmp     snmp \
    php7.2-soap \
    php7.2-sqlite3 \
    php7.2-sybase \
    php7.2-tidy \
    php7.2-xml \
    php7.2-xmlrpc \
    php7.2-xsl \
    php7.2-zip \
    php-amqp \
    php-apcu \
    php-apcu-bc \
    php-ds \
    php-gearman \
    php-geoip \
    php-igbinary \
    php-imagick     libmagickcore-6.q16-3-extra \
    php-mailparse \
    php-memcache \
    php-memcached \
    php-mongodb \
    php-msgpack \
    php-oauth \
    php-propro \
    php-radius \
    php-raphf \
    php-redis \
    php-rrd \
    php-smbclient \
    php-solr \
    php-ssh2 \
    php-stomp \
    php-uploadprogress \
    php-uuid \
    php-yaml \
    php-zmq \
    php-xdebug \

# php7.2-sodium - breaks php7.2-common
# php-ast - depends on php 7.1 api
# php-yac - conflicts with php-apcu
# php-gmagick - conflicts with php-imagick
# php-mongo - depends on php 5.6 api

# disable all php modules
ls -1 /etc/php/7.2/mods-available/ | sed 's/\.ini$//g' | xargs -I{} -n1 phpdismod -v ALL -s ALL {} 2>/dev/null
rm -fr /etc/php/5.6
rm -fr /etc/php/7.0
rm -rf /etc/php/7.1


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

