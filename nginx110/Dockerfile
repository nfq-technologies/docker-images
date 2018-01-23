FROM nfqlt/debian-stretch

ENV NFQ_DOCUMENT_ROOT /var/www/
ENV NFQ_RELOAD_PORT 1024

EXPOSE 80
CMD exec /entrypoint.sh

ADD build /build
RUN bash /build/setup_docker.sh && rm -Rf /build

