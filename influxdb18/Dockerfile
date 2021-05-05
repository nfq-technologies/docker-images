FROM nfqlt/debian-buster

VOLUME /var/lib/influxdb


EXPOSE 8086

ADD build /build
RUN bash /build/setup_docker.sh && rm -Rf /build


ENTRYPOINT ["/entrypoint.sh"]
CMD ["influxd"]
