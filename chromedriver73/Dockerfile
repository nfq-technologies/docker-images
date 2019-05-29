FROM nfqlt/debian-stretch

EXPOSE 4444


CMD exec /entrypoint.sh


ADD build /build
RUN bash /build/setup_docker.sh && rm -Rf /build

