mysql:
  image: __MYSQL_IMAGE__
  ports:
    - "__MYSQL_PORT__:3306"
  volumes_from:
    - mysqlVol


mysqlVol:
  image: __MYSQL_DATA_IMAGE__
  volumes:
     - /var/lib/mysql

