FROM nfqlt/debian-bullseye

EXPOSE 22
CMD exec bash -lc 'run-parts -v /etc/rc.d && exec /usr/sbin/sshd -De'

ADD build /build
RUN bash /build/setup_docker.sh && rm -Rf /build

