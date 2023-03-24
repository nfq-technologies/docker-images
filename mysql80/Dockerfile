FROM mysql:8.0
ENV MYSQL_ROOT_PASSWORD=root

ADD build /build
RUN bash /build/setup_docker.sh && rm -Rf /build

