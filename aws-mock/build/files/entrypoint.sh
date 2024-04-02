#!/bin/bash
set -e


# abandon all children, init proccess will take care of them on exit
trap 'exec true' EXIT


run-parts -v /etc/rc.d

#Run moto services with designated ports
echo "Starting defined AWS mock services ..."
if [[ -z $NFQ_AWS_SERVICES ]]; then
		echo "ERROR! Need to provide NFQ_AWS_SERVICES env variable with sercvices and ports ex.: ec2:4001 sqs:4002"
		exit 1
fi


echo "AWS services defined: $NFQ_AWS_SERVICES"
for service in $NFQ_AWS_SERVICES; do
    service_name="$(echo "$service" | cut -d: -f 1)"
	service_port="$(echo "$service" |cut -d: -f 2)"

	if [[ -z $service_name || -z $service_port ]]; then
			echo "ERROR! Malformed NFQ_AWS_SERVICES env variable! example: ec2:4001 sqs:4002"
			exit 1;
	fi
	
	echo "Starting $service_name on port $service_port ..."
	moto_server -H 0.0.0.0 -p $service_port &
done


sleep infinity

