#!/bin/bash

set -x
set -e

echo "deb https://packages.sury.org/php bullseye main" > /etc/apt/sources.list.d/sury.list
echo "deb-src https://packages.sury.org/php bullseye main" >> /etc/apt/sources.list.d/sury.list

wget --quiet https://packages.sury.org/php/apt.gpg
apt-key add apt.gpg
rm apt.gpg

cat >/etc/apt/preferences.d/sury <<EOF
  Package: php8.1-*
  Pin: origin packages.sury.org
  Pin-Priority: 600
EOF


apt-get update

apt-get install -y --no-install-recommends \
	php8.1-cli \
	php8.1-phpdbg \
	php8.1-bcmath \
	php8.1-bz2 \
	php8.1-common \
	php8.1-curl \
	php8.1-dba \
	php8.1-enchant \
	php8.1-gd \
	php8.1-gmp \
	php8.1-imagick libmagickcore-6.q16-6-extra \
	php8.1-imap \
	php8.1-interbase \
	php8.1-intl \
	php8.1-ldap \
	php8.1-mbstring \
	php8.1-mysql \
	php8.1-odbc		odbc-mdbtools \
	php8.1-opcache \
	php8.1-pgsql \
	php8.1-pspell \
	php8.1-readline \
	php8.1-snmp		snmp \
	php8.1-soap \
	php8.1-sqlite3 \
	php8.1-sybase \
	php8.1-tidy \
	php8.1-xml \
	php8.1-xmlrpc \
	php8.1-xsl \
	php8.1-xdebug \
	php8.1-zip \
	php8.1-amqp \
	php8.1-apcu \
	php8.1-ast \
	php8.1-ds \
	php8.1-igbinary \
	php8.1-mailparse \
	php8.1-memcache \
	php8.1-memcached \
	php8.1-mongodb \
	php8.1-msgpack \
	php8.1-oauth \
	php8.1-pcov \
	php8.1-psr \
	php8.1-raphf \
	php8.1-redis \
	php8.1-rrd \
	php8.1-smbclient \
	php8.1-solr \
	php8.1-ssh2 \
	php8.1-uuid \
	php8.1-yaml \
	php8.1-zmq \
	php8.1-xdebug \


#	php8.1-gmagick \ provides more stable api but conflicts with imagick
#	php8.1-yac \ conflicts with php8.1-apcu
#	php8.1-swoole \ Missing files
#	php8.1-gearman \ Missing files

# disable all php modules
ls -1 /etc/php/8.1/mods-available/ | sed 's/\.ini$//g' | xargs -I{} -n1 phpdismod -v ALL -s ALL {} 2>/dev/null

# cleanup older versions
rm -rf /etc/php/{5.6,7.0,7.1,7.2,7.3,7.4,8.0}

# backup original php.ini
mv /etc/php/8.1/cli/php.ini{,_orig}


# install custom php modules
apt-get install -y --no-install-recommends phyaml


# install dma (dragonfly mailer simple relay)
debconf-set-selections <<< "dma dma/mailname string"
debconf-set-selections <<< "dma dma/relayhost string mail"
apt-get install -y --no-install-recommends dma
echo '*: @' > /etc/aliases # force local mails to smarthost

# install custom pdo_snowflake php module
module_url=$(curl -s https://gitlab.com/api/v4/projects/40908162/releases | jq -r .[0].assets.links[0].direct_asset_url)
modules_dir=$(php -i | grep '^extension_dir' | awk '{print $5}')
wget $module_url -O pdo_snowflake.zip
unzip pdo_snowflake.zip
cp modules/pdo_snowflake.so $modules_dir
cp pdo_snowflake.ini /etc/php/8.1/mods-available/pdo_snowflake.ini


cp -frv /build/files/* / || true

# Clean up APT when done.
source /usr/local/build_scripts/cleanup_apt.sh

