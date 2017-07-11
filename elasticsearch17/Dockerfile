FROM nfqlt/debian-jessie

VOLUME ["/var/elasticsearch/data"]

WORKDIR /var/elasticsearch/data
CMD exec /entrypoint.sh

EXPOSE 9200

ENV ES_HEAP_SIZE="512m"

ADD build /build
RUN bash /build/setup_docker.sh && rm -Rf /build

