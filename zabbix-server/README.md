
## Zabbix server 5.0 with php frontend
  
### Info
This is an image of zabbix server with mysql support and php frontend.
On initial launch this image will configure db connection for both frontend and zabbix server itself from environment variables. Also it will import initial DB data if connected db is empty

### Frontend
PHP frontend is located under /user/share/zabbix

### DB Configuration
DB configuration is managed via env vars both for server and php frontned

NFQ_DB_HOST     mysql
NFQ_DB_NAME     project
NFQ_DB_USER     project
NFQ_DB_PASSWORD project

### Ports
**10051** - agent access

### docker-compose.yml example
```
version: '2.4'
services:
  mysql:
    image: 'mysql:5.7'
    ports:
      - '10.24.3.1:3306:3306'
    volumes_from:
      - 'service:mysqlVol:rw'


  mysqlVol:
    image: nfqlt/mysql57-data
    volumes:
      - /var/lib/mysql


  web:
    image: nfqlt/apache24-fastcgi
    ports:
      - '10.24.3.1:80:80'
    links:
      - fastcgi
    volumes_from:
      - 'service:zabbix:rw'
    environment:
      APACHE_DOCUMENTROOT: /usr/share/zabbix
      NFQ_PROJECT_ROOT: /usr/share/zabbix
      NFQ_ENABLE_APACHE_MODULES: rewrite


  fastcgi:
    image: nfqlt/php72-fpm
    links:
      - mysql
      - zabbix
    volumes_from:
      - 'service:zabbix:rw'
    environment:
      NFQ_PROJECT_ROOT: /usr/share/zabbix
      NFQ_ENABLE_PHP_MODULES: 'mysqlnd curl json mysqli ctype tokenizer simplexml intl mbstring xml zip dom xmlwriter xmlreader iconv gd sockets bcmath'


  zabbix:
    image: nfqlt/zabbix-server
    volumes:
      - /usr/share/zabbix
    ports:
      - '10.24.3.1:10051:10051'
    links:
      - mysql


  linker:
    image: nfqlt/linker18ce
    volumes:
      - '/run/docker.sock:/run/docker.sock'


volumes: {  }
networks:
  default:
    ipam:
      config:
        -
          subnet: 10.24.3.1/28
```

