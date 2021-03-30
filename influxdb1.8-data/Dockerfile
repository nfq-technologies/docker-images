FROM nfqlt/influxdb1.8

ENV DOCKER_INFLUXDB_INIT_USERNAME=project \
DOCKER_INFLUXDB_INIT_PASSWORD=projectproject \
INFLUXDB_DB=project

ADD build /build
CMD exec /build/volume-entrypoint.sh
