FROM nfqlt/toolbox-buster

ENV DEBIAN_FRONTEND=noninteractive

ADD build /build
RUN bash /build/setup_docker.sh && rm -Rf /build
