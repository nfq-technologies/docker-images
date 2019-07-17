FROM mysql:8.0

ENV MYSQL_ROOT_PASSWORD=root

ADD build /build
CMD exec /build/volume-entrypoint.sh

