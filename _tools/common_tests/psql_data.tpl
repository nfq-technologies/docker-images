psql:
  image: __PSQL_IMAGE__
  ports:
    - "__psql_PORT__:3306"
  volumes_from:
    - psqlVol


psqlVol:
  image: __PSQL_DATA_IMAGE__
  volumes:
     - /var/lib/postgresql/data

