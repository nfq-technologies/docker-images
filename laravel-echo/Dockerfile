FROM nfqlt/nodeserver6

ENV NFQ_DOCUMENT_ROOT /var/www
ENV NFQ_NPM_RUN start
ENV NFQ_BACKEND_PORT 6001

EXPOSE 80

ADD build /build
RUN bash /build/setup_docker.sh && rm -Rf /build

CMD exec /entrypoint.sh

