#!/bin/bash
set -e

stamp="$(date +%s%N)"
imageName="tmp${stamp}_es_image"
buildName="tmp${stamp}_es"

cleanup() {
	set +e
	rm -f es-data-Dockerfile
	rm -rf build/helpers
	rm -f backup.tar

	docker rm -vf "$buildName"
	docker rmi "$imageName"
}

trap cleanup EXIT


# temporary copy helpers
cp -r ../_tools/helpers/ build/helpers

# prepate volume
sed "s~FROM nfqlt~FROM ${2}nfqlt~" Dockerfile > .Dockerfile
docker build -f .Dockerfile -t "$imageName" ./
rm .Dockerfile

docker run --name "$buildName" "$imageName"
docker cp "$buildName":/backup.tar ./

# create temp dockerfile
echo -e 'FROM busybox\nADD backup.tar /\nADD build/entrypoint.sh /entrypoint.sh\n' > es-data-Dockerfile
echo -e 'CMD exec /entrypoint.sh\n' >> es-data-Dockerfile

# build volume image
docker build -t $1 -f es-data-Dockerfile ./

