FROM debian:bullseye

ENV DEBIAN_FRONTEND=noninteractive


CMD run-parts -v /etc/rc.d

ADD build /build
RUN bash /build/setup_docker.sh && rm -Rf /build

ENV TERM=xterm

