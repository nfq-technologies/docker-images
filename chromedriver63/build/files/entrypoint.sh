#!/bin/bash

set -e

source /tools/functions_init.sh

# abandon all children, init proccess will take care of them on exit
trap 'exec true' EXIT

init_wait_for_a_dir
init_wait_for_a_not_empty_dir
init_wait_for_a_file
init_wait_for_a_not_empty_file


xvfb-run chromedriver --verbose --url-base="wd/hub" --whitelisted-ips="" --port=4444

