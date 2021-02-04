#!/bin/bash

# Non empty trap
trap "kill -15 $PID" SIGTERM

sleep 2147483647 &
PID=$!

wait

