FROM nfqlt/debian-buster

CMD run-parts -v /etc/rc.d

ADD build /build
RUN bash /build/setup_docker.sh && rm -Rf /build

