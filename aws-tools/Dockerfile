FROM nfqlt/toolbox-bookworm

ADD build /build
RUN bash /build/setup_docker.sh && rm -Rf /build
ENV PATH /python/bin:$PATH
