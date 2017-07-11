

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

* apcu_bc
* apcu
* bcmath
* bz2
* calendar
* ctype
* curl
* dba
* dom
* enchant
* exif
* fileinfo
* ftp
* gd
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
* mbstring
* mcrypt
* memcached
* mongodb
* msgpack
* mysqli
* mysqlnd
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
* pspell
* readline
* recode
* redis
* shmop
* simplexml
* snmp
* soap
* sockets
* sqlite3
* ssh2
* sysvmsg
* sysvsem
* sysvshm
* tidy
* tokenizer
* wddx
* xdebug
* xml
* xmlreader
* xmlrpc
* xmlwriter
* xsl
* zip

