#!/bin/bash

set -e

run-parts -v /etc/rc.d


SRC="${NFQ_SOURCE_REPO}"
DST="${NFQ_TARGET_REPO}"
BDS="${NFQ_BIDIRECTIONAL}"


if [ "x${SRC}" = "x" ]
then
	echo "-- NFQ_SOURCE_REPO is not set, won't do anything..."
	exit 1
fi

if [ "x${DST}" = "x" ]
then
	echo "-- NFQ_TARGET_REPO is not set, won't do anything..."
	exit 2
fi


function simple_sync() {
	local SRC="$1"
	local DST="$2"
	rm -fr /dev/shm/gitsync
	mkdir -p /dev/shm/gitsync
	cd /dev/shm/gitsync
	git clone --bare "$SRC" .
	git remote add dest "$DST"
	git fetch origin --tags
	git push dest --mirror
}


if [ "x${BDS}" = "xtrue" ]
then
	echo "-- Bidirectional sync is not implemented yet."
	exit 3
else
	echo "++ Sync source: ${SRC}"
	echo "++ Sync target: ${DST}"

	export -f simple_sync
	su project -c bash -c "simple_sync '$SRC' '$DST'"


fi


