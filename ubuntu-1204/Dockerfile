FROM ubuntu:12.04

ENV DEBIAN_FRONTEND=noninteractive
ENV TERM=xterm


CMD run-parts -v /etc/rc.d

ADD build /build
RUN bash /build/setup_docker.sh && rm -Rf /build

ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US.UTF-8
ENV LC_ALL=en_US.UTF-8
ENV TERM=xterm

