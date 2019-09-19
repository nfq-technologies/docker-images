FROM nfqlt/nginx114

EXPOSE 80

ENV NFQ_PROXY_MAP ""

ADD build /build
RUN bash /build/setup_docker.sh && rm -Rf /build

