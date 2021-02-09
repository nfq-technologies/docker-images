#!/bin/sh

# Non empty trap
trap "kill -15 $PID" TERM

sleep 2147483647 &
PID=$!

wait

