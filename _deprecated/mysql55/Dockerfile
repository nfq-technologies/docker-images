FROM mysql:5.5
ENV MYSQL_ROOT_PASSWORD=root

ADD build /build
RUN bash /build/setup_docker.sh && rm -Rf /build

