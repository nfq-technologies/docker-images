FROM nfqlt/ubuntu-1804

ENV DEBIAN_FRONTEND=noninteractive

EXPOSE 22
CMD exec /entrypoint.sh

ADD build /build
RUN bash /build/setup_docker.sh && rm -Rf /build
