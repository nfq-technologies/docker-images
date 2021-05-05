FROM nfqlt/debian-buster

EXPOSE 3000
CMD exec /entrypoint.sh

ENV PATH="/usr/share/grafana/bin:$PATH" \
    GF_GID="472" \
    GF_UID="472" \
    GF_PATHS_CONFIG="/etc/grafana/grafana.ini" \
    GF_PATHS_DATA="/var/lib/grafana" \
    GF_PATHS_HOME="/usr/share/grafana" \
    GF_PATHS_LOGS="/var/log/grafana" \
    GF_PATHS_PLUGINS="/var/lib/grafana/plugins" \
    GF_PATHS_PROVISIONING="/etc/grafana/provisioning"


ADD build /build
RUN bash /build/setup_docker.sh && rm -Rf /build

USER grafana
ENTRYPOINT [ "/run.sh" ]
