FROM nfqlt/php80-cli

EXPOSE 9000
CMD exec /entrypoint.sh

ADD build /build
RUN bash /build/setup_docker.sh && rm -Rf /build

