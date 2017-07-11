FROM nfqlt/debian-wheezy

ENV NFQ_DOCUMENT_ROOT /tmp

EXPOSE 80
CMD exec /entrypoint.sh


ADD build /build
RUN bash /build/setup_docker.sh && rm -Rf /build

