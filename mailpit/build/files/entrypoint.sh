#!/bin/bash

set +e


# abandon all children, init proccess will take care of them on exit
trap 'exec true' EXIT


run-parts -v /etc/rc.d


exec /usr/local/bin/mailpit --smtp 0.0.0.0:25 --listen 0.0.0.0:80
