## AWS-Docker-Tools toolbox

### Info

This is an image of various AWS cli tools and docker in toolbox format

### Installed packages

- awscli
- awsebcli
- docker

### Configuration

Available binary paths for export:

- /usr/local/bin/aws
- /usr/local/bin/eb
- /usr/local/bin/ebp
- /usr/bin/docker

### Sample configuration

```
version: '2.4'
services:
  awstools:
    image: nfqlt/aws-docker-tools
    volumes:
      - './src:/home/project/src'
      - /tmp
      - /var/run/docker.sock:/var/run/docker.sock

  dev:
    image: nfqlt/php73-dev
    volumes_from:
      - service:awstools:rw
    volumes:
      - './src:/home/project/src'
      - '/home/project/.ssh:/home/project/.ssh'
      - '/etc/ssh:/etc/ssh'
      - '/etc/gitconfig:/etc/gitconfig'
      - '/etc/environment:/etc/environment-vm:ro'
    environment:
      NFQ_REMOTE_TOOL_AWSTOOLS: >
        /usr/local/bin/aws
        /usr/local/bin/eb
```

