#!/bin/bash
set -e

dockerfiles="$(grep "FROM " ./*/Dockerfile | tr ' ' '_' )"
root_dockerfiles="$(echo "$dockerfiles" | grep -v 'nfqlt' | tr ' ' '_' )"

levels="level_1 level_2 level_3 level_4 level_5"

function parse_children() {
	local parents="$1"

	for parent in ${!parents}; do
		# Print to stdout the output
		grep "FROM $parent" ./*/Dockerfile | cut -d"/" -f2 | xargs -I {} echo "nfqlt/"{}
	done
}



level_1=""

for dockerfile in ${root_dockerfiles}; do
	image="$(echo "${dockerfile}" | /usr/bin/cut -d'/' -f2)"
	level_1="nfqlt/$image
$level_1"
done

level_2="$(parse_children level_1)"
level_3="$(parse_children level_2)"
level_4="$(parse_children level_3)"
level_5="$(parse_children level_4)"


if [[ $1 =~ [1-5]{1} ]]; then
	level_to_print="level_$1"
	echo ${!level_to_print}
	exit 0
fi

echo -e $level_1 $level_2 $level_3 $level_4 $level_5;
