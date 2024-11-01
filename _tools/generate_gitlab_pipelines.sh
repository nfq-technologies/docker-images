#!/bin/bash
set -e

work_dir=$(dirname "$(dirname "$(realpath "$0")")")
cd "$work_dir"

levels="level_1 level_2 level_3 level_4 level_5"
level_1="$(_tools/sorting.sh 1)"
level_2="$(_tools/sorting.sh 2)"
level_3="$(_tools/sorting.sh 3)"
level_4="$(_tools/sorting.sh 4)"
level_5="$(_tools/sorting.sh 5)"

function ci_yml() {
	local image="$1"
	local level="$2"
	local parent="$3"

	automation='manual
  allow_failure: false'

	if [ "$level" != "level_1" ]; then
		automation='on_success'
	fi

	if [ -n "$parent" ]; then
		parent='"'$parent'"'
	fi

#	Overwrite here, to make EVERYTHING manual, good for re-running a single image
#	Gitlab ci does not yet support flags for dependency
#	automation='manual'
	buildfile="$(readlink $image/Makefile)"
	# If this is NOT a multi arch build
	if [ "$buildfile" == "../_tools/makefiles/base-image-Makefile" ]; then
		echo "
${image}:
  stage: $level
  before_script:
    # this ip has to go to host
    - echo "\$nfqhub_ip_os docker.nfq.lt" >> /etc/hosts
    - docker login -u \$dockerhub_user -p \$dockerhub_token
    - docker login -u \$nfqhub_user -p \$nfqhub_token https://docker.nfq.lt
  script: 'cd $image && make all-amd64 && make push-manifest && make publish && make clean'
  needs: [${image}_arm64]
  when: $automation
  tags: [nfq_ip]
${image}_arm64:
  stage: $level
  before_script:
    # this ip has to go to host
    - echo "\$nfqhub_ip_aws docker.nfq.lt" >> /etc/hosts
    - docker login -u \$dockerhub_user -p \$dockerhub_token
    - docker login -u \$nfqhub_user -p \$nfqhub_token https://docker.nfq.lt
  script: 'cd $image && make all-arm64 && make clean'
  tags: [arm]
  needs: [$parent]
  when: $automation
"
	else
		echo "
${image}:
  stage: $level
  script: 'cd $image && make all && make publish && make clean'
  needs: [$parent]
  when: $automation
"
	fi
}


for level in $levels; do
	echo "Generating level $level"
	destination_file="./_tools/gitlab/$level/config.yml"
	rm -f "./_tools/gitlab/$level/config.yml"
	for docker_image in ${!level}; do
		image_path="$(echo $docker_image | cut -d"/" -f2)"
		echo "Generating gitlab-ci.yml for image $docker_image"
		parent=""
		if [ "$level" != "level_1" ]; then
			parent="$(grep ^FROM ./$image_path/Dockerfile | cut -d' ' -f2 | cut -d'/' -f2)"
		fi
		echo "$(ci_yml "$image_path" "$level" "$parent")" >> $destination_file
	done
done
