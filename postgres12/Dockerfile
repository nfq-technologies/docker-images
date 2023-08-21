FROM postgres:12
ENV POSTGRES_USER=root POSTGRES_PASSWORD=root

ADD build /build
RUN bash /build/setup_docker.sh && rm -Rf /build

