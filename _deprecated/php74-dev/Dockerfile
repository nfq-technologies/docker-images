FROM nfqlt/php74-cli
ENV COMPOSER_VERSION=1

EXPOSE 22
CMD exec /entrypoint.sh

ADD build /build
RUN bash /build/setup_docker.sh && rm -Rf /build

