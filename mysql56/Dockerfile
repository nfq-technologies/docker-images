FROM mysql:5.6
ENV MYSQL_ROOT_PASSWORD=root

ADD build /build
RUN bash /build/setup_docker.sh && rm -Rf /build

