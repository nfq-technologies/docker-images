#!/bin/bash

set -e

levels="level_1 level_2 level_3 level_4 level_5"
level_1="$(_tools/relational_sorting.php 1)"
level_2="$(_tools/relational_sorting.php 2)"
level_3="$(_tools/relational_sorting.php 3)"
level_4="$(_tools/relational_sorting.php 4)"
level_5="$(_tools/relational_sorting.php 5)"



function ci_yml() {
	image="$1"
	if [ -n $parent ]; then
		parent='"'$parent'"'
	fi
	echo "
$image:
  image: nfqlt/aws-tools-docker
  tags: [nfq_ip]
  script: 'cd $image && make all'
  needs: [$parent]
  when: manual
"
}


for level in $levels; do
	echo "Generating level $level"
	for docker_image in ${!level}; do
		echo "Generating gitlab-ci.yml for image $docker_image"
		destination_file="./_tools/gitlab/$level/$docker_image.yml"
		echo "$destination_file"
		parent=""
		if [ "$level" != "level_1" ]; then
			parent="$(/bin/grep ^FROM ./$docker_image/Dockerfile | /usr/bin/cut -d' ' -f2)"
			echo "$(ci_yml "$docker_image" "$parent")" > $destination_file
		fi
	done
done
