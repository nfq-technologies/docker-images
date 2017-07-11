#!/bin/bash
set -e

# for tests when container does not have a link to fastcgi
fgrep -q fastcgi /etc/hosts || echo '127.0.0.1 web' >> /etc/hosts


CONFIGS="$(find /etc/nginx/ -type f)"
ENV_VARS="$(env | cut -d= -f1 | grep -v '^.$')"

for FILE_NAME in $CONFIGS
do
    for VAR_NAME in $ENV_VARS
    do
        eval VAR_VALUE="\$$VAR_NAME"
        PATTERN="s/\{$VAR_NAME\}/$(printf '%s' "$VAR_VALUE" | sed 's/[\/&]/\\&/g')/g"
        sed -ri "${PATTERN}" "${FILE_NAME}" 2>/dev/null || true # sed returns exit code 4 if var is not used in file
    done
done

# Start up
run-parts -v /etc/rc.d

# Generate cert
openssl req -x509 -batch -nodes -days 7 -newkey rsa:2048 -keyout /etc/nginx/cert.key -out /etc/nginx/cert.crt

# Launch nginx
exec nginx -g "daemon off;"

