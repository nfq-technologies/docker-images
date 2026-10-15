FROM nfqlt/debian-bookworm

EXPOSE 4444

ENV NFQ_PHANTOMJS_USE_WEBDRIVER "true"
ENV NFQ_PHANTOMJS_HOST 0.0.0.0
ENV NFQ_PHANTOMJS_PORT 4444
ENV NFQ_PHANTOMJS_OPTIONS --ignore-ssl-errors=yes

CMD exec /entrypoint.sh


ADD build /build
RUN bash /build/setup_docker.sh && rm -Rf /build

