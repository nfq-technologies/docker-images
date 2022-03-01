FROM nfqlt/debian-bullseye


EXPOSE 27017

CMD exec /entrypoint.sh


ADD build /build
RUN bash /build/setup_docker.sh && rm -Rf /build

