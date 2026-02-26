FROM nfqlt/debian-buster


EXPOSE 443
ENV NFQ_ROUTER_LOCAL_PORT 443
ENV NFQ_ROUTER_REMOTE_HOST example.com
ENV NFQ_ROUTER_REMOTE_PORT 443


CMD exec /entrypoint.sh


ADD build /build
RUN bash /build/setup_docker.sh && rm -Rf /build

