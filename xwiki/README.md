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
mysql:
  image: docker.nfq.lt/library/mysql:5.5
  environment:
    MYSQL_ROOT_PASSWORD: root

xwiki:
  image: nfqlt/xwiki
  links:
    - mysql
  ports:
    - "80:80"
```

