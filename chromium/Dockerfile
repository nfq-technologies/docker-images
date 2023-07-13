FROM nfqlt/toolbox-bookworm

EXPOSE 9222

ADD build /build
RUN bash /build/setup_docker.sh && rm -Rf /build
