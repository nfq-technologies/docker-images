

## supported env vars


### NFQ_PROJECT_ROOT (optional, required by some other options)

This var defines path to project root (repository).

#### Required by

* xdebug php module


### NFQ_ENABLE_PHP_MODULES (optional)

Provide space separated lists of modules in a single quoted string

example:
    docker run -it -e NFQ_ENABLE_PHP_MODULES='pdo pdo_mysql xdebug' <this_image>

__NOTE__: `opcache` and `ioncube` can't be enabled at the same time.

#### list of available modules

* ExactImage
* IcePHP
* adodb
* apcu
* curl
* enchant
* gd
* gdcm
* gearman
* geoip
* geos
* gmp
* gnupg
* gv
* igbinary
* imagick
* imap
* imlib
* interbase
* intl
* ioncube
* json
* lasso
* ldap
* libowphp
* libpuzzle
* libvirt-php
* mapscript
* mcrypt
* memcache
* memcached
* mongo
* msgpack
* mssql
* mysql
* mysqli
* oauth
* odbc
* opcache
* pdo
* pdo_dblib
* pdo_firebird
* pdo_mysql
* pdo_odbc
* pdo_pgsql
* pdo_sqlite
* pecl-http
* pgsql
* php_mapscript
* pinba
* propro
* pspell
* radius
* raphf
* readline
* recode
* redis
* redland
* remctl
* rrd
* sasl
* snmp
* solr
* sqlite3
* ssh2
* stomp
* svn
* tideways
* tidy
* tokyo_tyrant
* twig
* uprofiler
* wikidiff2
* xdebug
* xhprof
* xmlrpc
* xsl
* zend_loader
* zmq


