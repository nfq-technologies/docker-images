#!/bin/bash

DIR="$( cd "$( dirname $( dirname "${BASH_SOURCE[0]}" ))" && pwd )"

if [ -d  "$DIR/../../private" ]
then
	echo "docker.nfq.lt/"
else
	if [ -d  "$DIR/../../projects" ]
	then
		echo "sandbox-docker.nfq.lt/"
	else
		echo ""
	fi
fi
