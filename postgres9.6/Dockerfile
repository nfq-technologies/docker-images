FROM postgres:9.6

ENV POSTGRES_PASSWORD=project POSTGRES_UESR=project POSTGRES_DB=project

ADD build /build
RUN bash /build/setup_docker.sh && rm -Rf /build

