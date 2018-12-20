FROM nfqlt/debian-stretch

EXPOSE 8080
CMD exec /entrypoint.sh

ADD build /build
RUN bash /build/setup_docker.sh && rm -Rf /build

