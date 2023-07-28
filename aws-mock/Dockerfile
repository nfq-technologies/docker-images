FROM nfqlt/debian-bookworm

ENV NFQ_AWS_SERVICES "ec2:4001"

CMD exec /entrypoint.sh


ADD build /build
RUN bash /build/setup_docker.sh && rm -Rf /build
ENV PATH /python/bin:$PATH
