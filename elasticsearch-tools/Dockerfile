FROM nfqlt/nginx110


ENV NFQ_DOCUMENT_ROOT /var/www

EXPOSE 80

ADD build /build
RUN bash /build/setup_docker.sh && rm -Rf /build

CMD exec /entrypoint.sh

