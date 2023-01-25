FROM docker.nfq.lt/nfqlt/debian-bullseye


EXPOSE  5672
EXPOSE 15672

CMD run-parts -v /etc/rc.d && exec /entrypoint.sh


ADD build /build
RUN bash /build/setup_docker.sh && rm -Rf /build

