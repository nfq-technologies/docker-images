#!/bin/bash
# Generate NFQ_REMOTE_TOOL_* wrappers (needs root), then idle.
# The trap loop makes SIGTERM exit immediately; `sleep infinity` as PID 1
# would ignore it and make `docker compose stop` wait for the kill timeout.

set -e

run-parts -v /etc/rc.d

trap 'exit 0' TERM INT

while :; do
	sleep 1 &
	wait $!
done
