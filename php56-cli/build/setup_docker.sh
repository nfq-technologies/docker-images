#!/bin/bash

set -x
set -e

apt-get update

apt-get install -y --no-install-recommends php5-cli \
	libgv-php5 \
	libow-php5 \
	libpuzzle-php \
	php-imlib \
	php-wikidiff2 \
	php-zeroc-ice \
	php5-adodb \
	php5-apcu \
	php5-curl \
	php5-enchant \
	php5-exactimage \
	php5-gd \
	php5-gdcm \
	php5-gearman \
	php5-geoip \
	php5-geos \
	php5-gmp \
	php5-gnupg \
	php5-igbinary \
	php5-imagick \
	php5-imap \
	php5-interbase \
	php5-intl \
	php5-json \
	php5-lasso \
	php5-ldap \
	php5-librdf \
	php5-libvirt-php \
	php5-mapscript \
	php5-mcrypt \
	php5-memcache \
	php5-memcached \
	php5-mongo \
	php5-msgpack \
	php5-mysql \
	php5-oauth \
	php5-odbc \
	php5-pecl-http \
	php5-pgsql \
	php5-pinba \
	php5-propro \
	php5-pspell \
	php5-radius \
	php5-raphf \
	php5-readline \
	php5-recode \
	php5-redis \
	php5-remctl \
	php5-rrd \
	php5-sasl \
	snmp \
	php5-snmp \
	php5-solr \
	php5-sqlite \
	php5-ssh2 \
	php5-stomp \
	php5-svn \
	php5-sybase \
	php5-tidy \
	php5-tokyo-tyrant \
	php5-twig \
	php5-uprofiler \
	php5-xdebug \
	php5-xhprof \
	php5-xmlrpc \
	php5-xsl \
	php5-zmq \
	#php5-vtkgdcm \
	#php5-mysqlnd \
	#php5-mysqlnd-ms \
	#php5-yac \




# install custom php modules
apt-get install -y --force-yes --no-install-recommends \
	php56-zend-loader \
	php56-ioncube \
	nfq-php-tideways \


# disable all php modules
ls -1 /etc/php5/mods-available/ | sed 's/\.ini$//g' | xargs -I{} -n1 php5dismod {} 2>/dev/null
# deal with modules that does not symlink
mv /etc/php5/conf.d/* /etc/php5/mods-available/


# install dma (dragonfly mailer simple relay)
debconf-set-selections <<< "dma dma/mailname string"
debconf-set-selections <<< "dma dma/relayhost string mail"
apt-get install -y --no-install-recommends dma
echo '*: @' > /etc/aliases # force local mails to smarthost


cp -frv /build/files/* / || true


# Clean up APT when done.
source /usr/local/build_scripts/cleanup_apt.sh

