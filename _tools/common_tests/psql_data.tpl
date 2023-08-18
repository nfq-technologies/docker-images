psql:
  image: __PSQL_IMAGE__
  volumes_from:
    - psqlVol


psqlVol:
  image: __PSQL_DATA_IMAGE__
  volumes:
     - /var/lib/postgresql/data/pgdata

