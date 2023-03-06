#!/bin/bash

set -e

dockerfiles="$(grep "FROM " ./*/Dockerfile | tr ' ' '_' )"

levels="level_1 level_2 level_3 level_4 level_5"

function parse_level() {
	local level=$1
	local parent=$2
	local level_items=""

	for dockerfile in $dockerfiles; do
		image="$(echo $dockerfile | cut -d"/" -f2)"
		dep="$(echo $dockerfile | cut -d"_" -f2)"

		if [ "$level" == "level_1" ] && ! echo "$dep" | grep "nfqlt" > /dev/null; then
			level_items="nfqlt/$image\n$level_items"
			# Don't try the next if, as we already placed this item
			continue;
		fi

		# if parent exists and parent contains current image dependency then
		if [ -n "$parent" ] && echo "${!parent}" | grep -x '^'$dep'$' > /dev/null; then
			# Add that image to next level dependency
			level_items="nfqlt/$image\n$level_items"
		fi
	done
	echo -e "$level_items"
}

level_1="$(parse_level level_1)"
level_2="$(parse_level level_2 level_1)"
level_3="$(parse_level level_3 level_2)"
level_4="$(parse_level level_4 level_3)"
level_5="$(parse_level level_5 level_4)"

if [[ $1 =~ [1-5]{1} ]]; then
	level_to_print="level_$1"
	echo ${!level_to_print}
	exit 0
fi

echo $level_1 $level_2 $level_3 $level_4 $level_5;
