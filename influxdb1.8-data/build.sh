#!/bin/bash
set -e

TARGET_IMAGE="$(basename $(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd))"

# prepate volume
docker build -t tmp_build_image_$TARGET_IMAGE ./
docker run --name tmp_build_$TARGET_IMAGE -v "$(pwd):/volume" tmp_build_image_$TARGET_IMAGE

# create temp dockerfile
echo -e 'FROM docker.nfq.lt/nfqlt/influxdb1.8\nADD backup.tar /\nADD build/entrypoint.sh /entrypoint.sh\n' > influxdb-data-Dockerfile
echo -e 'CMD exec /entrypoint.sh\n' >> influxdb-data-Dockerfile


# build volume image
docker build -t $1 -f influxdb-data-Dockerfile ./

# cleanup
rm -f backup.tar
rm -f influxdb-data-Dockerfile
docker rm -vf tmp_build_$TARGET_IMAGE
docker rmi tmp_build_image_$TARGET_IMAGE

