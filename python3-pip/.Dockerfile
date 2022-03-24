FROM sandbox-docker.nfq.lt/nfqlt/debian-bullseye

ADD build /build
RUN bash /build/setup_docker.sh && rm -Rf /build

CMD exec /entrypoint.sh

