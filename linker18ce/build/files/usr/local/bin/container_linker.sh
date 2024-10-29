#!/bin/bash

function get_project_name {
    docker inspect --format '{{ index .Config.Labels "com.docker.compose.project" }}' "$1"
}

function get_project_containers {
    docker ps --format "{{.Names}}"
}

function generate_container_hosts {
    local CHILD="$1"
    local file="/tmp/${CHILD}.json"
    
    if ! docker inspect "$CHILD" > "$file"; then
        echo "Failed to inspect container $CHILD" >&2
        return 1
    fi

    local full_id short_id ip_address project service number

    full_id=$(jq -r '.[0].Id' "$file")
    short_id="${full_id:0:12}"
    ip_address=$(jq -r '.[0].NetworkSettings.Networks[].IPAddress' "$file")
    project=$(jq -r '.[0].Config.Labels."com.docker.compose.project"?' "$file")
    service=$(jq -r '.[0].Config.Labels."com.docker.compose.service"?' "$file")
    number=$(jq -r '.[0].Config.Labels."com.docker.compose.container-number"?' "$file")
    
    echo "$ip_address ${project}_${service}_${number} ${service}_${number} ${service} $short_id"
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
    while IFS= read -r CHILD; do
        generate_container_hosts "$CHILD" &
    done
    get_default_hosts
    wait
}

function get_custom_links {
    local child="$1"
    local hosts_file="$2"
    local project

    project=$(echo "$child" | cut -d_ -f1)

    jq '.[0].HostConfig.Links' "/tmp/${child}.json" \
       | tr -d ',"/ ' \
       | grep -F : \
       | sed "s/$child//" \
       | sed "s/${project}_//g" \
       | sed 's/_[0-9]*//g' \
       | grep -Ev '^(.*):\1$' |
    while IFS= read -r link; do
        local target_host custom_host target_ip
        
        target_host=$(echo "$link" | cut -d: -f1)
        custom_host=$(echo "$link" | cut -d: -f2)
        target_ip=$(grep -F "_${target_host}_" "$hosts_file" | awk '{print $1}')
        
        echo "$target_ip $custom_host"
    done
}

function get_hosts_for_container {
    local child="$1"
    local file="$2"

    cat "$file"
    get_custom_links "$child" "$file"
}

function update_container_hosts {
    local child="$1"
    local file="$2"

    get_hosts_for_container "$child" "$file" | docker exec -i "$child" sh -c 'cat - >/etc/hosts'
}

function distribute_hosts {
    local file="$2"
    while IFS= read -r child; do
        update_container_hosts "$child" "$file" &
    done < "$1"
    wait
}

function link_containers {
    echo -n "Linking project $PROJECT_NAME ... " >&2

    get_project_containers "$PROJECT_NAME" > containers.list
    echo -n "$(wc -l < containers.list) containers found ... " >&2

    get_hosts < containers.list | sort | uniq > hosts.txt
    echo -n "$(wc -l < hosts.txt) hosts collected ... " >&2

    distribute_hosts containers.list hosts.txt
    echo 'distribution done' >&2
}

SELF_CONTAINER_NAME=$(cat /etc/hostname)
PROJECT_NAME=$(get_project_name "$SELF_CONTAINER_NAME")

idle_timeout=20
idle_sleep=60

hosts=0
last_change=$(date +%s)
while true; do
    current_host_count=$(get_project_containers "$PROJECT_NAME" | wc -l)
    if (( hosts < current_host_count )); then
        hosts=$current_host_count
        link_containers "$PROJECT_NAME"
        last_change=$(date +%s)
    fi

    sleep 1

    if (( (last_change + idle_timeout) < $(date +%s) )); then
        sleep $idle_sleep
    fi
done

