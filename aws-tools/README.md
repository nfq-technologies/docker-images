## AWS-Tools toolbox

### Info

This is an image of various AWS cli tools in toolbox format

### Installed packages

- awscli
- awsebcli

### Configuration

Available binary paths for export:

- /usr/local/bin/aws
- /usr/local/bin/eb
- /usr/local/bin/ebp

### Sample configuration

```
version: '2.1'
services:
  awstools:
    image: nfqlt/aws-tools
    network_mode: bridge
    volumes:
      - './src:/home/project/src'
      - /tmp

  dev:
    image: nfqlt/php70-dev
    network_mode: bridge
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

