FROM nfqlt/php82-cli

EXPOSE 22
CMD exec /entrypoint.sh

ADD build /build
RUN bash /build/setup_docker.sh && rm -Rf /build

