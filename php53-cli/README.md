

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

* adodb
* apc
* curl
* enchant
* ffmpeg
* gd
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
* pam_auth
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
* sasl
* snmp
* sqlite
* sqlite3
* suhosin
* svn
* tideways
* tidy
* tokyo_tyrant
* uuid
* xdebug
* xmlrpc
* xsl
* zend_loader

