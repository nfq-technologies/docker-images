FROM nfqlt/debian-bookworm

ENV NFQ_DOCUMENT_ROOT /var/www
ENV NFQ_NPM_RUN serve
ENV NFQ_BACKEND_PORT 3000

EXPOSE 80

ADD build /build
RUN bash /build/setup_docker.sh && rm -Rf /build

CMD exec /entrypoint.sh

