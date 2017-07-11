FROM nfqlt/debian-jessie

ENV NFQ_DOCUMENT_ROOT /var/www
ENV NFQ_NPM_RUN serve

EXPOSE 80

ADD build /build
RUN bash /build/setup_docker.sh && rm -Rf /build

CMD exec /entrypoint.sh

