#!/bin/bash

set -e

source /tools/functions_init.sh

# abandon all children, init proccess will take care of them on exit
trap 'exec true' EXIT

init_wait_for_a_dir
init_wait_for_a_not_empty_dir
init_wait_for_a_file
init_wait_for_a_not_empty_file

chromium \
	--no-sandbox \
	--disable-background-networking \
	--disable-default-apps \
	--disable-extensions \
	--disable-sync \
	--disable-translate \
	--headless \
	--hide-scrollbars \
	--metrics-recording-only \
	--mute-audio \
	--no-first-run \
	--safebrowsing-disable-auto-update \
	--user-data-dir=/tmp \
	--disable-gpu \
	--remote-debugging-port=9222 \
	--remote-debugging-address=0.0.0.0

