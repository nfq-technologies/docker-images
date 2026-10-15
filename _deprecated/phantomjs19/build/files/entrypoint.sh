#!/bin/bash

set -e

source /tools/functions_init.sh

# abandon all children, init proccess will take care of them on exit
trap 'exec true' EXIT

init_wait_for_a_dir
init_wait_for_a_not_empty_dir
init_wait_for_a_file
init_wait_for_a_not_empty_file

if [ "${NFQ_PHANTOMJS_USE_WEBDRIVER}" == "true" ]; then
    phantomjs --webdriver=${NFQ_PHANTOMJS_HOST}:${NFQ_PHANTOMJS_PORT} ${NFQ_PHANTOMJS_OPTIONS}
else
    phantomjs ${NFQ_PHANTOMJS_OPTIONS}
fi
