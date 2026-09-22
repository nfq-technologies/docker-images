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

function get_ancestors() {
      local image="$1"
      local current="$image"
      local ancestors=""

      while true; do
              local dockerfile="./$current/Dockerfile"
              [ -f "$dockerfile" ] || break

              local parent_raw
              parent_raw="$(grep '^FROM ' "$dockerfile" | head -1 | awk '{print $2}')"
              local parent
              parent="$(echo "$parent_raw" | sed 's~^nfqlt/~~; s~^docker\.nfq\.lt/nfqlt/~~; s~^docker\.io/~~')"

              [ -d "./$parent" ] || break   # parent isn't one of ours -> external base, stop

              ancestors="$ancestors $parent"
              current="$parent"
      done

      echo "$ancestors"
}

function ci_yml() {
	local image="$1"
	local level="$2"
	local parent="$3"
  local ancestors
  ancestors="$(get_ancestors "$image")"
  local changes_yaml="        - \"$image/**/*\"
        - \"_tools/makefiles/**/*\"
        - \"_tools/helpers/**/*\""
  for anc in $ancestors; do
          changes_yaml="$changes_yaml
        - \"$anc/**/*\""
  done

	# Entry point jobs (_arm64 or single-arch): manual when MANUAL=true, otherwise cascade
	automation_entry="rules:
    - if: \$CI_PIPELINE_SOURCE == \"schedule\"
      when: on_success
    - if: \$MANUAL == \"true\"
      when: manual
      allow_failure: false
    - changes:
$changes_yaml
      when: on_success
    - when: never"

      # Manifest jobs (depend on _arm64): same condition, so it only
      # runs when its sibling _arm64 job actually ran.
      automation_manifest="rules:
    - if: \$CI_PIPELINE_SOURCE == \"schedule\"
      when: on_success
    - changes:
$changes_yaml
      when: on_success
    - when: never"
	if [ -n "$parent" ]; then
		parent='"'$parent'"'
	fi

  # For level 1 jobs
  if [ -n "$parent" ]; then
          parent_needs="needs: [{job: $parent, optional: true}]"
  else
          parent_needs="needs: []"
  fi

	buildfile="$(readlink $image/Makefile)"
	# If this is a multi arch build (has _arm64 and manifest jobs)
	if [ "$buildfile" == "../_tools/makefiles/base-image-Makefile" ]; then
		echo "${image}:
  stage: $level
  before_script:
    # IP override removed - using DNS now
    # - echo \$nfqhub_ip_os docker.nfq.lt >> /etc/hosts  # Commented out - using DNS now
    - docker login -u \$dockerhub_user -p \$dockerhub_token
    - docker login -u \$nfqhub_user -p \$nfqhub_token https://docker.nfq.lt
  script: 'cd $image && make all-amd64 && make push-manifest && make publish && make clean'
  needs: [{job: ${image}_arm64, optional: true}]
  $automation_manifest
  tags: [nfq_ip]
${image}_arm64:
  stage: $level
  before_script:
    # IP override removed - using DNS now
    # - echo \$nfqhub_ip_aws docker.nfq.lt >> /etc/hosts  # Commented out - using DNS now
    - docker login -u \$dockerhub_user -p \$dockerhub_token
    - docker login -u \$nfqhub_user -p \$nfqhub_token https://docker.nfq.lt
  script: 'cd $image && make all-arm64 && make clean'
  tags: [arm]
  $parent_needs
  $automation_entry
"
	else
		# Single arch build - treat as entry point
		echo "${image}:
  stage: $level
  script: 'cd $image && make all && make publish && make clean'
  $parent_needs
  $automation_entry
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
