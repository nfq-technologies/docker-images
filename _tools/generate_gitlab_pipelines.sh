#!/bin/bash

set -e

levels="level_1 level_2 level_3 level_4 level_5"
level_1="$(_tools/relational_sorting.php 1)"
level_2="$(_tools/relational_sorting.php 2)"
level_3="$(_tools/relational_sorting.php 3)"
level_4="$(_tools/relational_sorting.php 4)"
level_5="$(_tools/relational_sorting.php 5)"



function ci_yml() {
	local image="$1"
	local level="$2"
	local parent="$3"

	if [ -n "$parent" ]; then
		parent='"'$parent'"'
	fi
	echo "
$image:
  stage: $level
  needs: [$parent]
  when: manual
"
}


for level in $levels; do
	echo "Generating level $level"
	destination_file="./_tools/gitlab/$level/config.yml"
	rm -f "./_tools/gitlab/$level/config.yml"
	for docker_image in ${!level}; do
		echo "Generating gitlab-ci.yml for image $docker_image"
		parent=""
		if [ "$level" != "level_1" ]; then
			parent="$(grep ^FROM ./$docker_image/Dockerfile | cut -d' ' -f2 | cut -d'/' -f2)"
		fi
		echo "$(ci_yml "$docker_image" "$level" "$parent")" >> $destination_file
	done
done
