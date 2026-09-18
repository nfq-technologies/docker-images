FROM nfqlt/aws-tools

ADD build /build
RUN bash /build/setup_docker.sh && rm -Rf /build

# Enable legacy `docker build` behavior by default — buildx is still fully
# usable via `docker buildx build` for anything that needs it explicitly.
ENV DOCKER_BUILDKIT=0