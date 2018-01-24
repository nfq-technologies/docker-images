FROM nfqlt/debian-stretch


EXPOSE 80
ENV NFQ_CERT_DOMAIN_LIST example.com
ENV NFQ_CERT_EMAIL ""
ENV NFQ_CERTBOT_RENEW_CRON "15 10 * * *"
ENV NFQ_NOTIFY_HOST ""
ENV NFQ_NOTIFY_PORT 1234

CMD exec /entrypoint.sh


ADD build /build
RUN bash /build/setup_docker.sh && rm -Rf /build

