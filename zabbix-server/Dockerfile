FROM nfqlt/debian-buster

ENV NFQ_DB_HOST     mysql
ENV NFQ_DB_USER     project
ENV NFQ_DB_PASSWORD project
ENV NFQ_DB_NAME     project

EXPOSE 8080
CMD exec /entrypoint.sh

ADD build /build
RUN bash /build/setup_docker.sh && rm -Rf /build

