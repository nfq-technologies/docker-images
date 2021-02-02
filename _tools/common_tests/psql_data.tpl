psql:
  image: __PSQL_IMAGE__
  ports:
    - "__PSQL_PORT__:5432"
  volumes_from:
    - psqlVol


psqlVol:
  image: __PSQL_DATA_IMAGE__
  volumes:
     - /var/lib/postgresql/data/pgdata

