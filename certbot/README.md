
This image obtains and renews certificates from letsencrypt using certbot.
Currently only http challange is supported in standalone mode.

## supported env vars

### NFQ_CERT_DOMAIN_LIST

A space-separated list of domains to include in certificate. Certificate
 will be generated for the first domain and all other domains will be
 included as aliases.

### NFQ_CERT_EMAIL

Recovery email for certificate 

### NFQ_CERTBOT_RENEW_CRON

Interval of renew checs described in cron notation.

default: 15 10 * * *

