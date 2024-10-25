#!/bin/bash
set -e

TARGET_IMAGE="$(basename $(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd))"

# prepate volume
docker buildx build --platform linux/amd64 -t "tmp_build_image_$TARGET_IMAGE" ./
#docker build -t "tmp_build_image_$TARGET_IMAGE" ./
docker run -d --name "tmp_build_$TARGET_IMAGE" "tmp_build_image_$TARGET_IMAGE"
sleep 10
docker exec "tmp_build_$TARGET_IMAGE" ./build/volume-entrypoint.sh
docker cp "tmp_build_$TARGET_IMAGE:/backup.tar" ./

# create temp dockerfile
echo -e 'FROM busybox\nADD backup.tar /\nADD build/entrypoint.sh /entrypoint.sh\n' > mysql-data-Dockerfile
echo -e 'CMD exec /entrypoint.sh\n' >> mysql-data-Dockerfile


# build volume image
#docker build -t "$1" -f mysql-data-Dockerfile ./
docker buildx build --platform linux/amd64 -t "$1" -f mysql-data-Dockerfile ./

# cleanup
rm -f backup.tar
rm -f mysql-data-Dockerfile
docker rm -vf "tmp_build_$TARGET_IMAGE"
docker rmi "tmp_build_image_$TARGET_IMAGE"
