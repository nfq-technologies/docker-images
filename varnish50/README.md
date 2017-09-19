

## supported env vars


### NFQ_ENABLE_VARNISH_MODULES (optional)

Provide space separated lists of modules in a single quoted string

example:
    docker run -it -e NFQ_ENABLE_VARNISH_MODULES='saintmode cookie vsthrottle' <this_image>


#### list of available modules

* cookie
* header
* saintmode
* softpurge
* tcp
* var
* vsthrottle
* xkey


