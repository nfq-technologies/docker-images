# Proxy

## Info
This is general purpose proxy for use as a front entry point and distribute
 requests according to subdomains

## Limitations
SSL/TLS (https) connections are not supported

## Configuration

This image is based on nginx and exposes port __80__

### NFQ_PROXY_MAP

Provide space separated lists of map entries. Map entry consists of
 __nginx server_name pattern__ and __container name__ to redirect
 request to separated by a colon __:__

example:
    `docker run -it -e NFQ_PROXY_MAP='*:website app.*:backend cdn.*:media' <this_image>`

default values is empty.


### Sample configuration

The following configuration forwards __cdn.my.project.test__ to __media__ container,
 __backend.my.project.test__ to __backend__ container and every other subdomain
 to __website__ cotainer.

```
version: '2.4'
services:
  web:
    image: nfqlt/proxy
    links:
      - website
      - backend
      - media
    environment:
      NFQ_PROXY_MAP: >
        *:website
        backend.*:backend
        cdn.*:media:80


  website:
    image: nfqlt/apache24-php56
    environment:
      APACHE_DOCUMENTROOT: /home/project/src/web
    volumes:
      - ./:/home/project/src/web:ro


  backend:
    image: nfqlt/apache24-php56
    environment:
      APACHE_DOCUMENTROOT: /home/project/src/web
    volumes:
      - ./:/home/project/src/web:ro


  media:
    image: nfqlt/apache24-php56
    environment:
      APACHE_DOCUMENTROOT: /home/project/src/web
    volumes:
      - ./:/home/project/src/web:ro


```

