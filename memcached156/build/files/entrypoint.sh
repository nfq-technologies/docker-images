#!/bin/bash

set +e

# abandon all children, init proccess will take care of them on exit
trap 'exec true' EXIT


memcached $(cat /etc/memcached.conf)


