FROM nfqlt/debian-stretch


EXPOSE 9880
EXPOSE 24224


CMD exec /entrypoint.sh


ADD build /build
RUN bash /build/setup_docker.sh && rm -Rf /build

