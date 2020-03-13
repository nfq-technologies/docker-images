

## supported env vars


### NFQ_PROJECT_ROOT (optional, required by some other options)

This var defines path to project root (repository).

#### Required by

* xdebug php module


### NFQ_ENABLE_PHP_MODULES (optional)

Provide space separated lists of modules in a single quoted string

example:
    docker run -it -e NFQ_ENABLE_PHP_MODULES='pdo pdo_mysql xdebug' <this_image>

#### list of available modules

* amqp
* apcu_bc
* apcu
* ast
* bcmath
* bz2
* calendar
* ctype
* curl
* dba
* dom
* ds
* enchant
* exif
* ffi
* fileinfo
* ftp
* gd
* gearman
* geoip
* gettext
* gmp
* iconv
* igbinary
* imagick
* imap
* intl
* json
* ldap
* lua
* mailparse
* mbstring
* memcached
* memcache
* mongodb
* msgpack
* mysqli
* mysqlnd
* oauth
* odbc
* opcache
* pcov
* pdo_dblib
* pdo_firebird
* pdo
* pdo_mysql
* pdo_odbc
* pdo_pgsql
* pdo_sqlite
* pgsql
* phar
* posix
* propro
* pspell
* psr
* radius
* raphf
* readline
* redis
* rrd
* shmop
* simplexml
* smbclient
* snmp
* soap
* sockets
* solr
* sqlite3
* ssh2
* stomp
* sysvmsg
* sysvsem
* sysvshm
* tideways
* tidy
* tokenizer
* uopz
* uploadprogress
* uuid
* xdebug
* xml
* xmlreader
* xmlrpc
* xmlwriter
* xsl
* yaml
* zip
* zmq


