#!/bin/bash

set +x


# abandon all children, init proccess will take care of them on exit
trap 'exec true' EXIT


cmd="/usr/bin/certbot certonly --standalone -n --agree-tos --preferred-challenges http"


if [[ ! -z "$NFQ_CERT_EMAIL" ]]
then
	cmd+=" -m ${NFQ_CERT_EMAIL}"
else
	cmd+=" --register-unsafely-without-email"
fi


for domain in ${NFQ_CERT_DOMAIN_LIST}
do
	cmd+=" -d $domain"
done


echo "command: $cmd"
$cmd

echo setup crontab
echo "${NFQ_CERTBOT_RENEW_CRON} root $cmd 2>&1 | /usr/bin/logger -t certbot" >/etc/crontab

cron -n -L 1 &
syslogd -n -O /dev/stdout | stdbuf -i0 -oL -eL fgrep -v ' authpriv.'


