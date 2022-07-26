FROM mysql:8.0-debian
ENV default_authentication_plugin=mysql_native_password

ADD build /build
RUN bash /build/setup_docker.sh && rm -Rf /build

