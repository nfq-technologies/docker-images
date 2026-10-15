FROM mysql:5.7-debian
ENV MYSQL_ROOT_PASSWORD=root

ADD build /build
RUN bash /build/setup_docker.sh && rm -Rf /build

