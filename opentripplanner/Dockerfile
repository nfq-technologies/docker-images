FROM docker.io/opentripplanner/opentripplanner

ENV JAVA_TOOL_OPTIONS='-Xmx4g'

ADD build /build
RUN bash /build/setup_docker.sh && rm -Rf /build

