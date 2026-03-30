FROM nfqlt/php83-cli:amd64

EXPOSE 22
CMD exec /entrypoint.sh

ADD build /build
RUN bash /build/setup_docker.sh && rm -Rf /build

