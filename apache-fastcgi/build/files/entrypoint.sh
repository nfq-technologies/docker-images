#!/bin/bash

set -e


run-parts -v /etc/rc.d

# for tests when container does not have a link to fastcgi
fgrep -q fastcgi /etc/hosts || echo '127.0.0.1 fastcgi' >> /etc/hosts


exec apache2 -DFOREGROUND


