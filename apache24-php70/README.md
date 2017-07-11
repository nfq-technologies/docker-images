

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

<!--
ls /etc/apache2/mods-available/*.load | cut -d/ -f5 | rev | cut -d. -f2- | rev | sort | xargs -I{} -n1 bash -c 'F={}; ls /etc/apache2/mods-enabled/$F.load &>/dev/null && echo \* __${F}__ || echo \* $F'
-->

* __access_compat__
* actions
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
* __mime__
* mime_magic
* mpm_event
* __mpm_prefork__
* mpm_worker
* __negotiation__
* __php7.0__
* proxy
* proxy_ajp
* proxy_balancer
* proxy_connect
* proxy_express
* proxy_fcgi
* proxy_fdpass
* proxy_ftp
* proxy_hcheck
* proxy_html
* proxy_http
* proxy_http2
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
* status
* substitute
* suexec
* unique_id
* userdir
* usertrack
* vhost_alias
* xml2enc

### NFQ_ENABLE_PHP_MODULES (optional)

see [nfqlt/php70-cli/README.md](nfqlt/php70-cli/README.md) inherited by this image.

