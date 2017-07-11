FROM nfqlt/debian-jessie


EXPOSE 80
EXPOSE 12900

ENV NFQ_GRAYLOG_API_HOST graylog

CMD exec /entrypoint.sh


ADD build /build
RUN bash /build/setup_docker.sh && rm -Rf /build

