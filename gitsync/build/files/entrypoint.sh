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

	local SSUM="$(git ls-remote "$SRC" \
	| fgrep -v 'refs/pull/' \
	| fgrep -v 'refs/remotes/' \
	| fgrep -v 'refs/notes/' \
	| grep -v '\sHEAD$' \
	| md5sum -)"
	local DSUM="$(git ls-remote "$DST" \
	| fgrep -v 'refs/pull/' \
	| fgrep -v 'refs/remotes/' \
	| fgrep -v 'refs/notes/' \
	| grep -v '\sHEAD$' \
	| md5sum -)"

	if [ "$SSUM" == "$DSUM" ]
	then
		echo "~~ Repos are the same, nothing to do for now."
		return 0
	fi

	echo "++ Doing the actual sync"

	rm -fr /tmp/gitsync
	mkdir -p /tmp/gitsync
	cd /tmp/gitsync

	git clone --mirror "$SRC" .
	git push --all --prune --force "$DST"
	git push --tags --prune --force "$DST"
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


