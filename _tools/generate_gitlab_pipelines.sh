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

	buildfile="$(readlink $image/Makefile)"
	# If this is NOT a multi arch build
	if [ "$buildfile" == "../_tools/makefiles/base-image-amd64-Makefile" ]; then
		echo "
$image:
  stage: $level
  script: 'cd $image && make all && make publish'
  needs: [$parent]
  when: manual
"
	else
		echo "
${image}:
  stage: $level
  script: 'cd $image && make all-amd64 && make publish'
  needs: [${image}_arm64]
  when: manual
${image}_arm64:
  stage: $level
  script: 'cd $image && make all-arm64'
  tags: [arm]
  needs: [$parent]
  when: manual
"
	fi
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
