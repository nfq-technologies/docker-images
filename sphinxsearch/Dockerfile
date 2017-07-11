FROM nfqlt/debian-jessie

ENV NFQ_SPHINX_INDEXER_INTERVAL -1


EXPOSE 9312

CMD exec /entrypoint.sh


ADD build /build
RUN bash /build/setup_docker.sh && rm -Rf /build

