

## supported env vars


### NFQ_PROJECT_ROOT (optional, required by some other options)

This var defines path to project root (repository).

#### Required by

* xdebug php module


### NFQ_ENABLE_APACHE_MODULES (optional)

Provide space separated lists of modules in a single quoted string

example:
    docker run -it -e NFQ_ENABLE_APACHE_MODULES='rewrite' <this_image>

#### list of available modules (enabled by default shown in bold)

* actions
* __alias__
* asis
* __auth_basic__
* auth_digest
* authn_alias
* authn_anon
* authn_dbd
* authn_dbm
* authn_default
* __authn_file__
* authnz_ldap
* authz_dbm
* __authz_default__
* __authz_groupfile__
* __authz_host__
* authz_owner
* __authz_user__
* __autoindex__
* cache
* cern_meta
* __cgi__
* cgid
* charset_lite
* dav
* dav_fs
* dav_lock
* dbd
* __deflate__
* __dir__
* disk_cache
* dump_io
* __env__
* expires
* ext_filter
* file_cache
* filter
* headers
* ident
* imagemap
* include
* info
* ldap
* log_forensic
* mem_cache
* __mime__
* mime_magic
* __negotiation__
* __php5__
* proxy
* proxy_ajp
* proxy_balancer
* proxy_connect
* proxy_ftp
* proxy_http
* proxy_scgi
* __reqtimeout__
* rewrite
* __setenvif__
* speling
* ssl
* __status__
* substitute
* suexec
* unique_id
* userdir
* usertrack
* vhost_alias


### NFQ_ENABLE_PHP_MODULES (optional)

see [nfqlt/php54-cli/README.md](nfqlt/php54-cli/README.md) inherited by this image.
