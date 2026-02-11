

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
* interbase
* intl
* json
* ldap
* mailparse
* mbstring
* mcrypt
* memcached
* memcache
* mongodb
* msgpack
* mysqli
* mysqlnd
* oauth
* odbc
* opcache
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
* radius
* raphf
* readline
* recode
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
* tidy
* tokenizer
* uploadprogress
* uuid
* wddx
* xdebug
* xml
* xmlreader
* xmlrpc
* xmlwriter
* xsl
* yaml
* zip
* zmq


