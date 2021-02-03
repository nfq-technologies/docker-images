#!/bin/bash

error() {
	echo ERROR: $@ >&2
}

wait_for_connection() {
	if [ -z "$1" ]; then
		error "Usage: $0 host [timeout]"
		return 1
	fi

    local t1=$(date +%s)
	local t2=0
	local host="$1"
	local timeout="${2:-10}"

	while true; do
		if [[ $(wget -q --retry-connrefused --waitretry=1 -t 1 -T 1 "$host" -O /dev/null || echo $?) -ne 4 ]]; then
			return 0
		fi

		t2=$(date +%s)
		if [ $(($t2-$t1)) -ge $timeout ]; then
			return 1
		fi

		sleep 1
	done
}

wait_for_psql_connection() {
	if [ -z "$1" ]; then
		error "Usage: $0 host [timeout]"
		return 1
	fi

    local t1=$(date +%s)
	local t2=0
	local host="$(echo $1 | cut -d: -f1)"
	local port="$(echo $1 | cut -d: -f2)"
	local timeout="${2:-10}"

	while true; do
		if [[ $(echo -e '\x1dclose\x0d' | telnet "$host" "$port") == *"Connection closed."* ]]; then
			return 0
		fi

		t2=$(date +%s)
		if [ $(($t2-$t1)) -ge $timeout ]; then
			return 1
		fi

		sleep 1
	done
}

get_container_ip() {
	if [ -z "$1" ]; then
		error "Usage: $0 container_name"
		return 1
	fi

	local container="$1"
	local IP=$(docker inspect --format '{{ .NetworkSettings.IPAddress }}' "$container")

	if [ -z "$IP" ]; then
		error "Failed to get container: '$container' ip address"
		return 1
	fi

	echo "$IP"
}

if [ "${BASH_SOURCE[0]}" == "$0" ]
then
	set -e
	$@
fi

