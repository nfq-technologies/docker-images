FROM alpine

CMD exec /entrypoint.sh

ADD build /build
RUN sh /build/setup_docker.sh && rm -Rf /build

