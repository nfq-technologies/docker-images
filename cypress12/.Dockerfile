FROM docker.nfq.lt/nfqlt/node20

ADD build /build
RUN bash /build/setup_docker.sh && rm -Rf /build
