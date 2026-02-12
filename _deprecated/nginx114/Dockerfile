FROM nfqlt/debian-buster

ENV NFQ_DOCUMENT_ROOT /var/www/html
ENV NFQ_RELOAD_PORT 1024
ENV NFQ_FASTCGI_HOST fastcgi

EXPOSE 80
CMD exec /entrypoint.sh

ADD build /build
RUN bash /build/setup_docker.sh && rm -Rf /build

