## Terraform toolbox

### Info
This is an image of terraform 0.13

For help with Terraform visit project [homepage](https://www.terraform.io/docs/index.html) for documentation and guides.

### Global packages
This image has pre-installed terraform development tool

 - Terraform

### Configuration
Available binary paths for export:

- /usr/local/bin/terraform

To auth via env vars passed to dev container use
something like this in your init script to place
them in the .aws dir for terraform to find them
on execution.

```bash
until terraform --version &>/dev/null
do
	sleep 1
	echo Waiting for terraform link ...
done

aws configure set aws_access_key_id "${NFQ_SECRET_AWS_ACCESS_KEY_ID}"
aws configure set aws_secret_access_key "${NFQ_SECRET_AWS_SECRET_ACCESS_KEY}"
```

### Sample configuration for runing as tool
```
version: '2.4'
services:
  dev:
    image: nfqlt/php73-dev
    ports:
      - '10.24.1.241:22:22'
    volumes_from:
      - 'service:terraform:rw'
    volumes:
      - './src:/home/project/src'
      - '/home/project/.ssh:/home/project/.ssh'
      - '/etc/ssh:/etc/ssh'
      - '/etc/gitconfig:/etc/gitconfig'
      - '/etc/environment:/etc/environment-vm:ro'
      - '/vagrant/bash_custom:/home/project/.bash_custom'
    environment:
      NFQ_PROJECT_ROOT: /home/project/src
      NFQ_PROJECT_GIT_REPO: 'git@github.com:group/project.git'
      NFQ_PROJECT_GIT_BRANCH: master
      NFQ_INIT_SCRIPT: tools/docker/develop_init.sh
      NFQ_SECRET_AWS_ACCESS_KEY_ID: '${NFQ_SECRET_AWS_ACCESS_KEY_ID}'
      NFQ_SECRET_AWS_SECRET_ACCESS_KEY: '${NFQ_SECRET_AWS_SECRET_ACCESS_KEY}'
      NFQ_REMOTE_TOOL_TERRAFORM: >
        /usr/local/bin/terraform
      NFQ_REMOTE_TOOL_AWS: >
        /usr/local/bin/aws


  terraform:
    image: nfqlt/terraform013
    volumes_from:
      - 'service:aws:rw'
    volumes:
      - './src:/home/project/src'


  aws:
    image: nfqlt/aws-tools
    volumes:
      - /home/project/.aws
      - /tmp


  linker:
    image: nfqlt/linker18ce
    volumes:
      - '/run/docker.sock:/run/docker.sock'


volumes: {  }
networks:
  default:
    ipam:
      config:
        -
          subnet: 10.24.1.241/28

```

Start the container by running:

```export NFQ_SECRET_AWS_ACCESS_KEY_ID=KEY; export NFQ_SECRET_AWS_SECRET_ACCESS_KEY=SECRET; docker-compose up```
