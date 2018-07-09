#!/bin/bash

set -x
set -e

# Add backports repo
echo "deb http://deb.debian.org/debian wheezy-backports main" >> /etc/apt/sources.list

apt-get update

apt-get install -y --no-install-recommends php5-cli \
	php-apc \
	php5-exactimage \
	php5-ffmpeg \
	php5-gdcm \
	php5-vtkgdcm \
	php5-lasso \
	php5-mapscript \
	php5-ming \
	php5-adodb \
	php5-geoip \
	php5-imagick \
	php5-memcache \
	php5-memcached \
	php5-ps \
	php5-radius \
	php5-rrd \
	php5-sasl \
	php5-svn \
	php5-tokyo-tyrant \
	php5-curl \
	php5-enchant \
	php5-gd \
	php5-gmp \
	php5-imap \
	php5-interbase \
	php5-intl \
	php5-ldap \
	php5-mcrypt \
	php5-mysql \
	php5-odbc \
	php5-pgsql \
	php5-pspell \
	php5-recode \
	php5-snmp \
	php5-sqlite \
	php5-sybase \
	php5-tidy \
	php5-xmlrpc \
	php5-xsl \
	php5-librdf \
	php5-remctl \
	php5-xdebug \
	php5-redis \
	php5-mongo



# install zend loader
apt-get install -y --no-install-recommends \
	php54-zend-loader \
	nfq-php-tideways \



# disable all php modules
ls -1 /etc/php5/mods-available/ | sed 's/\.ini$//g' | xargs -I{} -n1 php5dismod {} 2>/dev/null
# deal with modules that does not symlink
mv /etc/php5/conf.d/* /etc/php5/mods-available/


# dma (dragonfly mta)
apt-get install -y --no-install-recommends dma-wheezy
echo '*: @' > /etc/aliases # force local mails to smarthost


cp -frv /build/files/* / || true


# Clean up APT when done.
source /usr/local/build_scripts/cleanup_apt.sh

