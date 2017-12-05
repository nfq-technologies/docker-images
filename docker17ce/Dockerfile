FROM nfqlt/debian-stretch


CMD /entrypoint.sh


ADD build /build
RUN bash /build/setup_docker.sh && rm -Rf /build

