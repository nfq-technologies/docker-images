## XWiki

### Info
Purpose of this image is to provide prebuilt image of [XWiki project](http://www.xwiki.org/xwiki/bin/view/Main/WebHome) 
Version: __8.4.1__

### Configuration
This image needs __mysql__ image linked with container name of __mysql__
This image exposes port __80__

### Environment variables
* __NFQ_MYSQL_ROOT_PASS__: root passwords of mysql image

### Volumes
You can create volumes for data persistence

  * __/root/xwiki/data/storage/xwiki__ attachments storage

### Sample configuration
```
version: '2.1'
services:
  mysql:
    image: mysql:5.5
    network_mode: bridge
    environment:
      MYSQL_ROOT_PASSWORD: root


  xwiki:
    image: nfqlt/xwiki
    network_mode: bridge
    links:
      - mysql
    ports:
      - "80:80"
```

