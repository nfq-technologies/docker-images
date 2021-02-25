FROM nfqlt/postgres12

ENV POSTGRES_PASSWORD=project POSTGRES_DB=project

ADD build /build
CMD exec /build/volume-entrypoint.sh
