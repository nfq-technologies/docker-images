#!/bin/bash
set -x
set -e

run-parts -v /etc/rc.d


SRC="${NFQ_SOURCE_REPO}"
DST="${NFQ_TARGET_REPO}"
BDS="${NFQ_BIDIRECTIONAL}"
SRC_KEY="${NFQ_SECRET_SOURCE_KEY}"
DST_KEY="${NFQ_SECRET_DESTINATION_KEY}"


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
	local SRC_KEY="$3"
	local DST_KEY="$4"
	local SRC_GIT_SSH="ssh"
	local DST_GIT_SSH="ssh"

	if [ ! -z "$SRC_KEY" ]; then
		echo "$SRC_KEY" > /tmp/src_key
		SRC_GIT_SSH="ssh -i /tmp/src_key"
	fi

	if [ ! -z "$DST_KEY" ]; then
		echo "$DST_KEY" > /tmp/dst_key
		DST_GIT_SSH="ssh -i /tmp/dst_key"
	fi

	local SSUM="$(GIT_SSH_COMMAND="$SRC_GIT_SSH" git ls-remote "$SRC" \
	| fgrep -v 'refs/pull/' \
	| fgrep -v 'refs/remotes/' \
	| fgrep -v 'refs/notes/' \
	| grep -v '\sHEAD$' \
	| md5sum -)"
	local DSUM="$(GIT_SSH_COMMAND="$DST_GIT_SSH" git ls-remote "$DST" \
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

	GIT_SSH_COMMAND="$SRC_GIT_SSH" git clone --mirror "$SRC" .
	GIT_SSH_COMMAND="$DST_GIT_SSH" git push --all --prune --force "$DST"
	GIT_SSH_COMMAND="$DST_GIT_SSH" git push --tags --prune --force "$DST"
}


if [ "x${BDS}" = "xtrue" ]
then
	echo "-- Bidirectional sync is not implemented yet."
	exit 3
else
	echo "++ Sync source: ${SRC}"
	echo "++ Sync target: ${DST}"

	export -f simple_sync
	su project -c bash -c "simple_sync '$SRC' '$DST' '$SRC_KEY' '$DST_KEY'"
fi

