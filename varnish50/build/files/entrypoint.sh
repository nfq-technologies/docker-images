#!/bin/bash


CONFIGS="/etc/default/varnish /etc/varnish/default.vcl"
ENV_VARS="$(env | cut -d= -f1 | grep -v '^.$')"


for FILE_NAME in $CONFIGS
do
    for VAR_NAME in $ENV_VARS
    do
        eval VAR_VALUE="\$$VAR_NAME"
        PATTERN="s/\{$VAR_NAME\}/$(printf '%s' "$VAR_VALUE" | sed 's/[\/&]/\\&/g')/g"
        sed -ri "${PATTERN}" "${FILE_NAME}" 2>/dev/null
    done
done



run-parts -v /etc/rc.d

source /etc/default/varnish
exec varnishd -F $DAEMON_OPTS

