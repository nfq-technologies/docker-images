FROM nfqlt/php73-dev

ENV XAUTHORITY /home/project/.Xauthority

ADD build /build
RUN bash /build/setup_docker.sh && rm -Rf /build


