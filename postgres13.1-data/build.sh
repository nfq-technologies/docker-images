#!/bin/bash
set -e

TARGET_IMAGE="$(basename $(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd))"

# prepate volume
docker build -t tmp_build_image_$TARGET_IMAGE ./
docker run --name tmp_build_$TARGET_IMAGE -v "$(pwd):/volume" tmp_build_image_$TARGET_IMAGE

# create temp dockerfile
echo -e 'FROM busybox\nADD backup.tar /\nADD build/entrypoint.sh /entrypoint.sh\n' > psql-data-Dockerfile
echo -e 'CMD exec /docker-entrypoint.sh\n' >> psql-data-Dockerfile


# build volume image
docker build -t $1 -f psql-data-Dockerfile ./

# cleanup
rm -f backup.tar
rm -f psql-data-Dockerfile
docker rm -vf tmp_build_$TARGET_IMAGE
docker rmi tmp_build_image_$TARGET_IMAGE

