#!/bin/bash


function get_project_name {
	docker inspect --format '{{ index .Config.Labels "com.docker.compose.project" }}' "$1"
}

function get_project_containers {
	docker ps --format "{{.Names}}"
}

function generate_container_hosts {
	CHILD=$1
	file=/tmp/${CHILD}.json
	docker inspect $CHILD > $file
	full_id=$(jq '.[0].Id?' $file | tr -d '"')
	short_id=$(echo $full_id | head -c12)
	ip_address=$(jq -r '.[0].NetworkSettings.Networks[].IPAddress' $file)
	project=$(jq '.[0].Config.Labels."com.docker.compose.project"?' $file | tr -d '"')
	service=$(jq '.[0].Config.Labels."com.docker.compose.service"?' $file | tr -d '"')
	number=$(jq '.[0].Config.Labels."com.docker.compose.container-number"?' $file | tr -d '"')
	echo "$ip_address	${project}_${service}_${number} ${service}_${number} ${service} $short_id"
}

function get_default_hosts {
	cat <<EOF
127.0.0.1	localhost
::1			localhost ip6-localhost ip6-loopback
fe00::0		ip6-localnet
ff00::0		ip6-mcastprefix
ff02::1		ip6-allnodes
ff02::2		ip6-allrouters

EOF
}

function get_hosts {
	for CHILD in $(cat -)
	do
		generate_container_hosts $CHILD &
	done
	get_default_hosts
	wait
}

function get_custom_links {
	child=$1
	project=$(echo $child | cut -d_ -f1)
    json_file=/tmp/${child}.json
	hosts_file=$2

	for link in $(jq '.[0].HostConfig.Links' $json_file \
				| tr -d ',"/ ' \
				| fgrep : \
				| sed "s/$child//" \
				| sed "s/${project}_//g" \
				| sed 's/_[0-9]*//g' \
				| grep -Ev '^(.*):\1$' \
	)
	do
		target_host=$(echo $link | cut -d: -f1)
		custom_host=$(echo $link | cut -d: -f2)
		target_ip=$(fgrep _${target_host}_ $hosts_file | awk '{print $1}')
		echo $target_ip $custom_host
	done
}

function get_hosts_for_container {
	child=$1
	file=$2

	cat $file
	get_custom_links $child $file
}

function update_container_hosts {
	child=$1
	file=$2

	get_hosts_for_container $child $file | docker exec -i $child sh -c 'cat - >/etc/hosts'
}

function distribute_hosts {
	file=$2
	for child in $(cat $1)
	do
		update_container_hosts $child $file &
	done
	wait
}

function link_containers {
	echo -n "Linking project $PROJECT_NAME ... " >&2

	get_project_containers $PROJECT_NAME > containers.list
	echo -n "$(cat containers.list | wc -l) containers found ... " >&2

	get_hosts < containers.list | sort | uniq > hosts.txt
	echo -n "$(cat hosts.txt | wc -l) hosts collected ... " >&2

	distribute_hosts containers.list hosts.txt
	echo 'distribution done' >&2
}

SELF_CONTAINER_NAME=$(cat /etc/hostname)
PROJECT_NAME=$(get_project_name $SELF_CONTAINER_NAME)

idle_timeout=20
idle_sleep=60



hosts=0
last_change=$(date +%s)
while true
do
	if [ $hosts -lt $(get_project_containers $PROJECT_NAME | wc -l) ]
	then
		hosts=$(get_project_containers $PROJECT_NAME | wc -l)
		link_containers $PROJECT_NAME
		last_change=$(date +%s)
	fi

	sleep 1

	if [ $(($last_change+$idle_timeout)) -lt $(date +%s) ]
	then
		sleep $idle_sleep
	fi
done



