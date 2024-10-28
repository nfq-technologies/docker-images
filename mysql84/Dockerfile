FROM mysql:8.4
ENV MYSQL_ROOT_PASSWORD=project
ENV MYSQL_DATABASE=project
ENV MYSQL_USER=project
ENV MYSQL_PASSWORD=project

ADD build /build
RUN bash /build/setup_docker.sh && rm -Rf /build

