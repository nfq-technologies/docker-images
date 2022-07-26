FROM nfqlt/debian-bullseye

ENV NFQ_DOCUMENT_ROOT /var/www/html
ENV NFQ_RELOAD_PORT 1024
ENV NFQ_FASTCGI_HOST fastcgi
ENV SITES_ENABLED_ROOT /etc/nginx/sites-enabled/*

EXPOSE 80
CMD exec /entrypoint.sh

ADD build /build
RUN bash /build/setup_docker.sh && rm -Rf /build

