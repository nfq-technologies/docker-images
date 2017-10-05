#!/bin/bash
set -e


source /tools/functions_init.sh

run-parts -v /etc/rc.d

# default features
init_wait_for_a_dir
init_wait_for_a_not_empty_dir
init_wait_for_a_file
init_wait_for_a_not_empty_file

# support startup trigger
init_use_startup_trigger


envKey="NFQ_PROXY_MAP"

if [ -z "${!envKey}" ]
then
	echo "-- Warning: $envKey is empty, this container does nothing now."
else
	echo -e "# This file is generated from $envKey env variable.\n\n" >/etc/nginx/sites-available/default

	for map in ${!envKey}
	do
		localHost=$(echo "$map" | cut -d: -f1)
		remoteHost=$(echo "$map" | cut -d: -f2)
		remotePort=$(echo "$map" | cut -d: -f3)
		remotePort=${remotePort:=80}

		if [ "$localHost" == "*" ]
		then
			serverName=""
			defaultServer="default"
			defaultServerSet=true
		else
			serverName="server_name $localHost;"
			defaultServer=""
		fi


		init_wait_for_connection_nc $remoteHost $remotePort 60 || (echo "-- ERROR: upstream host [$remoteHost] TIMEDOUT" ; exit 1)

		echo "++ Adding proxy ${localHost} -> $remoteHost:$remotePort"

		cat /usr/local/share/nfqlt_proxy/nginx_server.tpl \
		| sed "s~{{ defaultServer }}~$defaultServer~" \
		| sed "s~{{ serverName }}~$serverName~" \
		| sed "s~{{ remoteHost }}~$remoteHost:$remotePort~" \
		>>/etc/nginx/sites-available/default
	done

	if [ -z "$defaultServerSet" ]
	then
		echo -e "\nserver {\n	listen 80 default;\n	return 404;\n}\n" \
		>>/etc/nginx/sites-available/default
	fi
fi

exec nginx -g "daemon off;"

