FROM nfqlt/debian-wheezy

ENV NFQ_LISTEN_PORT 80
ENV NFQ_BACKEND_HOST 127.0.0.1
ENV NFQ_BACKEND_PORT 8080

EXPOSE 80
CMD exec /entrypoint.sh


ADD build /build
RUN bash /build/setup_docker.sh && rm -Rf /build

