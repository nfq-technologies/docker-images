#!/bin/bash
set -e


# Prepare server config
sed -i "s/# DBHost=localhost/DBHost=$NFQ_DB_HOST/" /etc/zabbix/zabbix_server.conf
sed -i "s/DBName=zabbix/DBName=$NFQ_DB_NAME/" /etc/zabbix/zabbix_server.conf
sed -i "s/DBUser=zabbix/DBUser=$NFQ_DB_USER/" /etc/zabbix/zabbix_server.conf
sed -i "s/# DBPassword=/DBPassword=$NFQ_DB_PASSWORD/" /etc/zabbix/zabbix_server.conf
sed -i "s/# AllowRoot=0/AllowRoot=1/" /etc/zabbix/zabbix_server.conf
sed -i "s/# LogType=file/LogType=console/" /etc/zabbix/zabbix_server.conf


# Wait for mysql connection
source /tools/functions_init.sh
echo "# Waiting for mysql on host:'$NFQ_DB_HOST' ..."
if ! init_wait_for_connection_nc "$NFQ_DB_HOST" 3306 10; then
	echo "## Can't connect to mysql on host '$NFQ_DB_HOST' exiting."
	exit 1
fi


# Check if mysql initial data is present
echo "# Checking if zabbix db is populated ..."
if ! mysql -e "desc $NFQ_DB_NAME.users" -h"$NFQ_DB_HOST" -u"$NFQ_DB_USER" -p"$NFQ_DB_PASSWORD" &> /dev/null; then
	echo "## Populating db ..."
	zcat /usr/share/doc/zabbix-server-mysql*/create.sql.gz | mysql -h"$NFQ_DB_HOST" -u"$NFQ_DB_USER" -p"$NFQ_DB_PASSWORD" "$NFQ_DB_NAME"
else
	echo "## Zabbix db already populated, skipping"
fi


# Prepare php frontend config
sed -i "s/\$DB\['SERVER'].*/\$DB['SERVER']=\"$NFQ_DB_HOST\";/" /usr/share/zabbix/conf/zabbix.conf.php
sed -i "s/\$DB\['DATABASE'].*/\$DB['DATABASE']=\"$NFQ_DB_NAME\";/" /usr/share/zabbix/conf/zabbix.conf.php
sed -i "s/\$DB\['USER'].*/\$DB['USER']=\"$NFQ_DB_USER\";/" /usr/share/zabbix/conf/zabbix.conf.php
sed -i "s/\$DB\['PASSWORD'].*/\$DB['PASSWORD']=\"$NFQ_DB_PASSWORD\";/" /usr/share/zabbix/conf/zabbix.conf.php

# Start server
exec zabbix_server -f

