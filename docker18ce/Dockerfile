FROM nfqlt/debian-bullseye


CMD /entrypoint.sh


ADD build /build
RUN bash /build/setup_docker.sh && rm -Rf /build

