FROM debian:buster

ENV DEBIAN_FRONTEND=noninteractive


CMD run-parts -v /etc/rc.d

ADD build /build
RUN bash /build/setup_docker.sh && rm -Rf /build

ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US.UTF-8
ENV LC_ALL=en_US.UTF-8
ENV TERM=xterm

