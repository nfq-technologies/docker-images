FROM nfqlt/debian-trixie

ENV CLAUDE_CONFIG_DIR=/home/project/.claude
CMD exec /entrypoint.sh

ADD build /build
RUN bash /build/setup_docker.sh && rm -Rf /build
