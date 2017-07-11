

## supported env vars

example:
    docker run -it --rm -e NFQ_ENABLE_APACHE_MODULES='rewrite' [this_image]


### APACHE_DOCUMENTROOT (optional)

Sets apache document root to specified path. You don't need to change that for
projects following standard structure.

default value: /home/project/src/www/web


### APACHE_RUN_DIR (optional)

default value: /var/run/apache2


### NFQ_FCGI_IDLE_TIMEOUT (optional)

Communication timeout in seconds with remote fastcgi process (eg. php-fpm).
You'll need to increase this timeout for long running jobs executed via
webserver.

default value: 30


### NFQ_ENABLE_APACHE_MODULES (optional)

Provide space separated lists of modules in a single quoted string

default value: [empty]

#### list of available modules (enabled by default shown in bold)


* __access_compat__
* ___actions___
* __alias__
* allowmethods
* asis
* __auth_basic__
* auth_digest
* auth_form
* authn_anon
* __authn_core__
* authn_dbd
* authn_dbm
* __authn_file__
* authn_socache
* authnz_fcgi
* authnz_ldap
* __authz_core__
* authz_dbd
* authz_dbm
* authz_groupfile
* __authz_host__
* authz_owner
* __authz_user__
* __autoindex__
* buffer
* cache
* cache_disk
* cache_socache
* cgi
* cgid
* charset_lite
* data
* dav
* dav_fs
* dav_lock
* dbd
* __deflate__
* dialup
* __dir__
* dump_io
* echo
* __env__
* expires
* ext_filter
* ___fastcgi___
* file_cache
* __filter__
* headers
* heartbeat
* heartmonitor
* ident
* include
* info
* lbmethod_bybusyness
* lbmethod_byrequests
* lbmethod_bytraffic
* lbmethod_heartbeat
* ldap
* log_debug
* log_forensic
* lua
* macro
* __mime__
* mime_magic
* ___mpm_event___
* mpm_prefork
* mpm_worker
* __negotiation__
* proxy
* proxy_ajp
* proxy_balancer
* proxy_connect
* proxy_express
* proxy_fcgi
* proxy_fdpass
* proxy_ftp
* proxy_html
* proxy_http
* proxy_scgi
* proxy_wstunnel
* ratelimit
* reflector
* remoteip
* reqtimeout
* request
* rewrite
* sed
* session
* session_cookie
* session_crypto
* session_dbd
* __setenvif__
* slotmem_plain
* slotmem_shm
* socache_dbm
* socache_memcache
* socache_shmcb
* speling
* ssl
* _status_
* substitute
* suexec
* unique_id
* userdir
* usertrack
* vhost_alias
* xml2enc


