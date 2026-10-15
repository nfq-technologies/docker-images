FROM nfqlt/php74-cli

EXPOSE 9001

ENV NFQ_SUPERVISOR_CONF_DIR /etc/supervisor/conf.d
ENV NFQ_SUPERVISOR_ENABLE_HTTP false
ENV NFQ_USE_STARTUP_TRIGGER false

CMD exec /entrypoint.sh

ADD build /build
RUN bash /build/setup_docker.sh && rm -Rf /build

