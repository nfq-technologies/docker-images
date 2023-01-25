FROM mariadb:10
ENV MYSQL_ROOT_PASSWORD=project \
    MYSQL_DATABASE=project \
    MYSQL_USER=project \
    MYSQL_PASSWORD=project


ADD build /build
RUN bash /build/setup_docker.sh && rm -Rf /build

