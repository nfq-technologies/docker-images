FROM nfqlt/nginx110

EXPOSE 443

ADD build /build
RUN bash /build/setup_docker.sh && rm -Rf /build

