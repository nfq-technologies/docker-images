#!/bin/bash

set -e

EXEC=$(realpath "$0")
images="$(/usr/bin/find ./ -type f -name Dockerfile | cut -d"/" -f2 | awk '{print "nfqlt/" $1}' )"



function image_check(){
	image=$1
	arch=$2
	has_image="$(docker manifest inspect $image --verbose | grep '"architecture"' | cut -d\" -f4)"
#	echo "$has_image"
	if echo "$has_image" | grep "$arch" > /dev/null; then
		echo "https://hub.docker.com/r/$image/tags for arm exists"
	fi;
}

export -f image_check;

#for image in $images; do

#	echo "Working image $image"
#	docker manifest inspect --verbose "$image" | jq -r '.[]|.Descriptor.platform|(.architecture)'
#	echo "$images" | xargs -I {} -n1 bash -c "image_check {} arm64"
#done


echo "$images" | xargs -I {} -n1 -P60 bash -c "image_check {} arm64"
