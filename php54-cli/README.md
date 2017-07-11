

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

* apc
* adodb
* curl
* enchant
* ffmpeg
* gd
* gdcm
* geoip
* gmp
* imagick
* imap
* interbase
* intl
* lasso
* ldap
* mcrypt
* memcache
* memcached
* ming
* mssql
* mysql
* mysqli
* odbc
* pdo
* pdo_dblib
* pdo_firebird
* pdo_mysql
* pdo_odbc
* pdo_pgsql
* pdo_sqlite
* pgsql
* ps
* pspell
* radius
* recode
* redland
* rrd
* sasl
* snmp
* sqlite3
* svn
* tidy
* tokyo_tyrant
* vtkgdcm
* xdebug
* xmlrpc
* xsl

#### list of available modules from debian backports, use with extreme caution

* mongo
* redis


