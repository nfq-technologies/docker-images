FROM nfqlt/toolbox-bookworm

ENV QPDF_VERSION=12.0.0

ADD build /build
RUN bash /build/setup_docker.sh && rm -Rf /build
