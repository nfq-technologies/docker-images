FROM mysql:8.0

ADD build /build
RUN bash /build/setup_docker.sh && rm -Rf /build

ENV MYSQL_ROOT_PASSWORD=root
