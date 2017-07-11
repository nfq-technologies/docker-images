#!/bin/bash

set -x
set -e

apt-get update

apt-get install -y --no-install-recommends php5-cli \
	php-apc \
	php5-adodb \
	php5-auth-pam \
	php5-curl \
	php5-enchant \
	php5-exactimage \
	php5-ffmpeg \
	php5-gd \
	php5-geoip \
	php5-gmp \
	php5-imagick \
	php5-imap \
	php5-interbase \
	php5-intl \
	php5-lasso \
	php5-ldap \
	php5-librdf \
	php5-mapscript \
	php5-mcrypt \
	php5-memcache \
	php5-memcached \
	php5-ming \
	php5-mysql \
	php5-odbc \
	php5-pgsql \
	php5-ps \
	php5-pspell \
	php5-radius \
	php5-recode \
	php5-remctl \
	php5-sasl \
	php5-snmp \
	php5-sqlite \
	php5-suhosin \
	php5-svn \
	php5-sybase \
	php5-tidy \
	php5-tokyo-tyrant \
	php5-uuid \
	php5-xdebug \
	php5-xmlrpc \
	php5-xsl


# disable all php modules
mkdir -p /etc/php5/mods-available
ls -1 /etc/php5/mods-available/ | sed 's/\.ini$//g' | xargs -I{} -n1 php5dismod {} 2>/dev/null
# deal with modules that does not symlink
mv /etc/php5/conf.d/* /etc/php5/mods-available/


# install custom php modules
apt-get install -y --force-yes --no-install-recommends \
	php53-zend-loader \
	php53-tideways \


# install dma (dragonfly mailer simple relay)
debconf-set-selections <<< "dma dma/mailname string"
debconf-set-selections <<< "dma dma/relayhost string mail"
apt-get install -y --no-install-recommends dma
echo '*: @' > /etc/aliases # force local mails to smarthost


cp -frv /build/files/* /


# Clean up APT when done.
source /usr/local/build_scripts/cleanup_apt.sh

