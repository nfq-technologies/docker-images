FROM nfqlt/debian-jessie

ENV NFQ_MYSQL_ROOT_PASS root

EXPOSE 80

ADD build /build
RUN bash /build/setup_docker.sh && rm -Rf /build

CMD exec /entrypoint.sh

