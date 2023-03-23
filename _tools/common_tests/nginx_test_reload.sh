#!/bin/bash
set -e

pid="$BASHPID"

# shellcheck source=../../_tools/helpers/common.sh
source "../_tools/helpers/common.sh"

function cleanup() {
	docker stop "test${pid}" > /dev/null
	docker rm -vf "test${pid}" > /dev/null
}
trap cleanup EXIT

docker run -d --name "test${pid}" \
		"$1" > /dev/null

container_ip="$(get_container_ip "test${pid}")"

wait_for_connection "${container_ip}"

function test_response () {
	local expected="$1"
	response="$(curl -s -o /dev/null -w "%{http_code}" "http://${container_ip}/")"

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

nc "$container_ip" 1024
sleep 1
echo -n "Testing after reload ... "
test_response 200

