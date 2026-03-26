version: "2"
services:
  mysql:
    image: __MYSQL_IMAGE__
    volumes_from:
      - mysqlVol

  mysqlVol:
    image: __MYSQL_DATA_IMAGE__

