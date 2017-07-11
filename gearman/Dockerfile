FROM nfqlt/debian-jessie

EXPOSE 4730

ENV NFQ_GEARMAND_VERBOSE WARNING
ENV NFQ_GEARMAND_CONFIG ""
ENV NFQ_USE_STARTUP_TRIGGER false

CMD exec /entrypoint.sh

ADD build /build
RUN bash /build/setup_docker.sh && rm -Rf /build
