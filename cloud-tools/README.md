## Cloud-Tools toolbox

### Info

This is an image of various cloud cli tools in toolbox format

### Installed packages

- awscli
- awsebcli
- docker
- az
- kubectl

### Configuration

Available binary paths for export:

- /usr/local/bin/aws
- /usr/local/bin/eb
- /usr/local/bin/ebp
- /usr/bin/docker
- /usr/bin/kubectl
- /usr/bin/az

### Sample configuration

```
version: '2.4'
services:
  cloudtools:
    image: nfqlt/cloud-tools
    volumes:
      - './src:/home/project/src'
      - /tmp
      - /var/run/docker.sock:/var/run/docker.sock

  dev:
    image: nfqlt/php73-dev
    volumes_from:
      - service:cloudtools:rw
    volumes:
      - './src:/home/project/src'
      - '/home/project/.ssh:/home/project/.ssh'
      - '/etc/ssh:/etc/ssh'
      - '/etc/gitconfig:/etc/gitconfig'
      - '/etc/environment:/etc/environment-vm:ro'
    environment:
      NFQ_REMOTE_TOOL_CLOUDTOOLS: >
        /usr/local/bin/aws
        /usr/local/bin/az
```

