FROM nfqlt/debian-stretch

ENV NFQ_DOCUMENT_ROOT /var/www/

EXPOSE 80
CMD exec /entrypoint.sh


ADD build /build
RUN bash /build/setup_docker.sh && rm -Rf /build

