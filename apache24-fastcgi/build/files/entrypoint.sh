#!/bin/bash

set -e


run-parts -v /etc/rc.d


# fake fastcgi for tests when container does not have a link to fastcgi
if [[ "x$APACHE_DOCUMENTROOT" == "x/var/www" || "x$NFQ_DOCUMENT_ROOT" == "x/var/www" ]]
then
	fgrep -q fastcgi /etc/hosts || echo '127.0.0.1 fastcgi' >> /etc/hosts
fi


exec apache2 -DFOREGROUND


