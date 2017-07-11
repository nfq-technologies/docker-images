FROM nfqlt/debian-jessie


CMD /entrypoint.sh


ADD build /build
RUN bash /build/setup_docker.sh && rm -Rf /build

