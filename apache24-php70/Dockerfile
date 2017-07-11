FROM nfqlt/php70-cli

ENV APACHE_DOCUMENTROOT /var/www
ENV APACHE_RUN_DIR /var/run/apache2

EXPOSE 80
CMD run-parts -v /etc/rc.d && exec apache2 -DFOREGROUND

ADD build /build

RUN bash /build/setup_docker.sh && rm -Rf /build

