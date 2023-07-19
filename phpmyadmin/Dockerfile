FROM nfqlt/php82-cli

EXPOSE 80
ENV NFQ_ENABLE_PHP_MODULES "ctype tokenizer intl mbstring iconv mysqlnd mysqli"
ENV NFQ_DB_USER "project"
ENV NFQ_DB_PASSWORD "project"

ADD build /build
RUN bash /build/setup_docker.sh && rm -Rf /build

CMD exec /entrypoint.sh

