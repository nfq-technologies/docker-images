FROM nfqlt/php73-cli

ENV PHP_FPM_post_max_size=8M PHP_FPM_upload_max_filesize=2M PHP_FPM_memory_limit=128M

EXPOSE 9000
CMD exec /entrypoint.sh

ADD build /build
RUN bash /build/setup_docker.sh && rm -Rf /build

