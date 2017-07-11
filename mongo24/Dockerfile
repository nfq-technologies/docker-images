FROM nfqlt/debian-jessie


EXPOSE 27017
EXPOSE 28017

CMD exec /entrypoint.sh


ADD build /build
RUN bash /build/setup_docker.sh && rm -Rf /build

