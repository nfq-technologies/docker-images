#!/bin/bash


error() {
    echo ERROR: $@ >&2
}

init_use_startup_trigger() {
	local ST=$(echo "${NFQ_USE_STARTUP_TRIGGER}" | tr '[:upper:]' '[:lower:]')
	if [ "x${ST}" = "xtrue" ]
	then
		echo "++ Waiting for startup trigger on port 2048 ..."
		netcat -l -p 2048 -c 'echo service startup triggered.'
	fi
}

init_wait_for_a_dir() {
	if [ "x$1" != "x" ]
	then
		local DR="$1"
	else
		local DR="${NFQ_WAIT_FOR_A_DIR}"
	fi

	if [ "x${DR}" != "x" ]
	then
		echo "++ Waiting for a dir at $DR"
		while [ ! -d "$DR" ]
		do
		    sleep 1
		done
		echo "++ dir at $DR found"
	fi
}

init_wait_for_a_not_empty_dir() {
	if [ "x$1" != "x" ]
	then
		local DR="$1"
	else
		local DR="${NFQ_WAIT_FOR_A_NOT_EMPTY_DIR}"
	fi

	if [ "x${DR}" != "x" ]
	then
		echo "++ Waiting for a non-empty dir at $DR"
		while [[ ! -d "$DR" || $(ls -A1 "$DR" | wc -l) -eq 0 ]]
		do
		    sleep 1
		done
		echo "++ non-empty dir found at $DR"
	fi
}

init_wait_for_a_file() {
	if [ "x$1" != "x" ]
	then
		local DR="$1"
	else
		local DR="${NFQ_WAIT_FOR_A_FILE}"
	fi

	if [ "x${DR}" != "x" ]
	then
		echo "++ Waiting for a file at $DR"
		while [[ ! -e "$DR" ]]
		do
		    sleep 1
		done
		echo "++ file at $DR found"
	fi
}

init_wait_for_a_not_empty_file() {
	if [ "x$1" != "x" ]
	then
		local DR="$1"
	else
		local DR="${NFQ_WAIT_FOR_A_NOT_EMPTY_FILE}"
	fi

	if [ "x${DR}" != "x" ]
	then
		echo "++ Waiting for a file non-empty at $DR"
		while [[ ! -s "$DR" ]]
		do
		    sleep 1
		done
		echo "++ non-empty file found at $DR"
	fi
}

init_wait_for_connection() {
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

		if [[ $timeout -ne 0 && "$timeout" != "infinity" ]]; then
			t2=$(date +%s)
			if [ $(($t2-$t1)) -ge $timeout ]; then
				return 1
			fi
		fi

		sleep 1
	done
}

init_wait_for_connection_nc() {
	if [[ -z "$1" ]] || [[ -z "$2" ]]; then
		error "Usage: $0 host port [timeout]"
		return 1
	fi

	local t1=$(date +%s)
	local t2=0
	local host="$1"
	local port="$2"
	local timeout="${3:-10}"

	until netcat -z -w1 $host $port </dev/null >/dev/null 2>&1; do
		if [[ $timeout -ne 0 && "$timeout" != "infinity" ]]; then
			t2=$(date +%s)
			if [ $(($t2-$t1)) -ge $timeout ]; then
				return 1
			fi
		fi

		sleep 0.05
	done
}

