influxdb:
  image: __INFLUXDB_IMAGE__
  ports:
    - "__INFLUXDB_PORT__:8086"
  volumes_from:
    - influxdbVol


influxdbVol:
  image: __INFLUXDB_DATA_IMAGE__
  volumes:
     - /var/lib/influxdb

