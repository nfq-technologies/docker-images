## AWS-MOCK container
This is a tool for mocking Amazon Web Services locally. Its based on python integration of moto
More info on supported services could be found https://github.com/spulec/moto

## supported env vars


### NFQ_AWS_SERVICE (required)

Provide space separated lists of services and their ports

example:
    docker run -it -e NFQ_AWS_SERVICES='ec2:4001 s3:4002' <this_image>


#### list of available modules

Refer to https://github.com/spulec/moto

#### Example docker compose

```
version: '2.1'
services:
  aws:
    image: nfqlt/aws-mock
    network_mode: bridge
    environment:
      NFQ_AWS_SERVICES: >
        ec2:4001
        sqs:4002

```

To use it with for example aws cli
```
aws --endpoint-url="http://aws:4001" ec2 run-instances --image-id=ami-0001
```

