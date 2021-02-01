FROM postgres:13.1

ENV POSTGRES_PASSWORD=root

ADD build /build
CMD exec /build/volume-entrypoint.sh

