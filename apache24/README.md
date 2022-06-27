## About apache24

This image contains the latest apache release of version 2.4 and will contain latest bugfix versions


## supported env vars

example:
    docker run -it --rm -e NFQ_ENABLE_APACHE_MODULES='rewrite' [this_image]


### APACHE_DOCUMENTROOT (optional)

Sets apache document root to specified path. You don't need to change that for
projects following standard structure.

default value: /home/project/src/www/web


### SITES_ENABLED_ROOT (optional)

Location where sites-enabled configuration is stored, full path

default value: sites-enabled
Note: translates to /etc/apache2/sites-enabled


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


* access_compat
* __actions__
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
* brotli
* buffer
* cache
* cache_disk
* cache_socache
* cern_meta
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
* fcgid
* file_cache
* __filter__
* headers
* heartbeat
* heartmonitor
* http2
* ident
* imagemap
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
* md
* __mime__
* mime_magic
* __mpm_event__
* mpm_prefork
* mpm_worker
* __negotiation__
* __proxy__
* proxy_ajp
* proxy_balancer
* proxy_connect
* proxy_express
* __proxy_fcgi__
* proxy_fdpass
* proxy_ftp
* proxy_hcheck
* proxy_html
* proxy_http
* proxy_http2
* proxy_scgi
* proxy_uwsgi
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
* socache_redis
* socache_shmcb
* speling
* ssl
* status
* substitute
* suexec
* unique_id
* userdir
* usertrack
* vhost_alias
* xml2enc


