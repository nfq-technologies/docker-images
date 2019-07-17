#!/bin/bash
set -e

/entrypoint.sh mysqld &
mysqlPid=$!

while ! mysql -uroot -p${MYSQL_ROOT_PASSWORD} -e 'show databases' &> /dev/null; do
	sleep 1
done

mysql -uroot -proot -e "CREATE DATABASE project;"
mysql -uroot -proot -e "CREATE USER 'project'@'%' IDENTIFIED WITH mysql_native_password BY 'project';"
mysql -uroot -proot -e "GRANT ALL PRIVILEGES ON \`project%\`.* TO 'project'@'%';"

kill $mysqlPid
wait

tar cf /volume/backup.tar /var/lib/mysql
sync

