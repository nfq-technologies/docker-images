version: "2"
services:
  psql:
    image: __PSQL_IMAGE__
    volumes_from:
      - psqlVol

  psqlVol:
    image: __PSQL_DATA_IMAGE__

