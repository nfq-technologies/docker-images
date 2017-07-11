#!/bin/bash

set +e


# abandon all children, init proccess will take care of them on exit
trap 'exec true' EXIT


run-parts -v /etc/rc.d


while true
do
	/usr/local/bin/mailhog  -smtp-bind-addr 0.0.0.0:25 -api-bind-addr 0.0.0.0:80 -ui-bind-addr 0.0.0.0:80 \
	| fgrep -v \
		-e '[APIv1] KEEPALIVE /api/v1/events' \

done

