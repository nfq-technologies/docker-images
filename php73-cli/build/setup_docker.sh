#!/bin/bash

set -x
set -e

apt-get update

apt-get install -y --no-install-recommends \
	php7.3-cli \
	php-phpdbg \
	libow-php7 \
	php7.3-bcmath \
	php7.3-bz2 \
	php7.3-common \
	php7.3-curl \
	php7.3-dba \
	php7.3-enchant \
	php7.3-gd \
	php7.3-gmp \
	php7.3-imap \
	php7.3-interbase \
	php7.3-intl \
	php7.3-json \
	php7.3-ldap \
	php7.3-mbstring \
	php7.3-mysql \
	php7.3-odbc       odbc-mdbtools \
	php7.3-opcache \
	php7.3-pgsql \
	php7.3-pspell \
	php7.3-readline \
	php7.3-recode \
	php7.3-snmp       snmp \
	php7.3-soap \
	php7.3-sqlite3 \
	php7.3-sybase \
	php7.3-tidy \
	php7.3-xml \
	php7.3-xmlrpc \
	php7.3-zip \
	php-amqp \
	php-apcu \
	php-apcu-bc \
	php-ast \
	php-ds \
	php-excimer \
	php-gearman \
	php-geoip \
	php-geos \
	php-gnupg \
	php-horde-lz4 \
	php-http \
	php-igbinary \
	php-imagick       libmagickcore-6.q16-6-extra \
	php-lua \
	php-luasandbox \
	php-mailparse \
	php-mapi \
	php-memcache \
	php-memcached \
	php-mongodb \
	php-msgpack \
	php-oauth \
	php-pinba \
	php-propro \
	php-ps \
	php-radius \
	php-raphf \
	php-redis \
	php-remctl \
	php-rrd \
	php-sass \
	php-smbclient \
	php-solr \
	php-ssh2 \
	php-stomp \
	php-uploadprogress \
	php-uuid \
	php-wikidiff2 \
	php-yaml \
	php-zeroc-ice \
	php-zmq \


#	php-gmagick \ provides more stable api but conflicts with imagick
#	php-yac \ conflicts with php-apcu
#	php-tideways \ conflicts with nfq-php-tideways

#	php-guestfs \ depends on kernel module management stuff ~50mb
#	php-facedetect \ depends on libopencv and friends ~150mb
#	php-libvirt-php \ depends on virtualization management



# add missing odbc symlink
#mkdir -p /usr/lib/x86_64-linux-gnu/odbc
#ln -s /usr/lib/x86_64-linux-gnu/libodbccr.so.1 /usr/lib/x86_64-linux-gnu/odbc/libodbccr.so

#TODO: Fallback to debian package, when xdebug is updated from RC2: https://bugs.xdebug.org/bug_view_page.php?bug_id=00001642
cd /tmp
XDEBUG_DEB="php7.3-xdebug_*debian10*_amd64.deb"

rsync "rsync://rsync.sury.org/repositories/php/pool/main/x/xdebug/$XDEBUG_DEB" .
dpkg -i $XDEBUG_DEB
rm -f $XDEBUG_DEB

# disable all php modules
ls -1 /etc/php/7.3/mods-available/ | sed 's/\.ini$//g' | xargs -I{} -n1 phpdismod -v ALL -s ALL {} 2>/dev/null

# cleanup older versions
rm -rf /etc/php/7.{0,1,2,4}

# backup original php.ini
mv /etc/php/7.3/cli/php.ini{,_orig}


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

