FROM nfqlt/debian-buster

ENV NFQ_BIDIRECTIONAL=false

CMD exec /entrypoint.sh

ADD build /build
RUN bash /build/setup_docker.sh && rm -Rf /build

