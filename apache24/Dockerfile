FROM nfqlt/debian-bookworm

ENV APACHE_DOCUMENTROOT /var/www
ENV APACHE_RUN_DIR /var/run/apache2
ENV NFQ_FCGI_IDLE_TIMEOUT 30
ENV SITES_ENABLED_ROOT sites-enabled

EXPOSE 80
CMD exec /entrypoint.sh

ADD build /build

RUN bash /build/setup_docker.sh && rm -Rf /build

