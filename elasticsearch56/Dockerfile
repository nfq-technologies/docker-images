FROM nfqlt/debian-stretch


VOLUME ["/var/elasticsearch/data"]
WORKDIR /var/elasticsearch/data


EXPOSE 9200

ADD build /build
RUN bash /build/setup_docker.sh && rm -Rf /build

ENV ES_JAVA_OPTS="-Xms512m -Xmx512m"

CMD exec /entrypoint.sh

