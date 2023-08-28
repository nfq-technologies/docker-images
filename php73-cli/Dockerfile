FROM nfqlt/debian-bullseye

ENV PHP_CLI_post_max_size=8M PHP_CLI_upload_max_filesize=2M PHP_CLI_memory_limit=-1

CMD run-parts -v /etc/rc.d

ADD build /build
RUN bash /build/setup_docker.sh && rm -Rf /build

