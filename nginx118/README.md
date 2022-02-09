## Image
Nginx 1.18

## supported env vars

example:
    docker run -it --rm -e NFQ_DOCUMENT_ROOT='/home/project/src/web' [this_image]


### NFQ_DOCUMENT_ROOT (optional)

Sets nginx document root to specified path.

default value: /var/www


### NFQ_RELOAD_PORT (optional)

Port number that will reload configuration files after connection.
Used for dynamic site configuration loading or ssl sertificates update

default value: 1024


### NFQ_FASTCGI_HOST (optional)

Host to forward php files execution to. To disable fastcgi support provide
either value 'false' or set an empty value to this variable.

default value: fastcgi

