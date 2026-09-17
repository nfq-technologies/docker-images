FROM nfqlt/debian-trixie

ENV CLAUDE_CONFIG_DIR=/home/project/.claude
ENV SSH_ASKPASS=/usr/local/bin/ssh-askpass-project \
    SSH_ASKPASS_REQUIRE=force
CMD exec /entrypoint.sh

ADD build /build
RUN bash /build/setup_docker.sh && rm -Rf /build
