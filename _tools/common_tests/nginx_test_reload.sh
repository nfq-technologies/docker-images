#!/bin/bash
set -e

pid="$BASHPID"
web_port="$pid"
reload_port=$((web_port+1))

# shellcheck source=../../_tools/helpers/common.sh
source "../_tools/helpers/common.sh"

function cleanup() {
	docker stop "test${pid}" > /dev/null
	docker rm -vf "test${pid}" > /dev/null
}
trap cleanup EXIT

docker run -d --name "test${pid}" \
		-p ${web_port}:80 \
		-p ${reload_port}:1024 \
		"$1" > /dev/null
wait_for_connection "localhost:${web_port}"

function test_response () {
	local expected="$1"
	response="$(curl -s -o /dev/null -w "%{http_code}" http://localhost:${web_port}/)"

	if [[ "$response" == "$expected" ]]; then
		echo OK
	else
		echo ERROR
		exit 1
	fi
}

echo -n "Testing unmodified config ... "
test_response 403

docker cp "./test/configurations/test_default" "test${pid}:/etc/nginx/sites-available/default"
echo -n "Testing after config replace ... "
test_response 403

nc localhost $reload_port
sleep 1
echo -n "Testing after reload ... "
test_response 200

