## thrift toolbox

### Info
This is an image of thrift 0.9.1 version in toolbox format


### Configuration
Available binary paths for export:

- /usr/bin/thrift


### Sample configuration
```
version: '2.1'
services:
  thrift:
    image: nfqlt/thrift091
    network_mode: bridge
    volumes_from:
      - ./src:/home/project/src
      - /tmp

  dev:
    image: nfqlt/php56-dev
    network_mode: bridge
    volumes_from:
      - service:thrift:rw
    volumes:
      - ./src:/home/project/src
      - /home/project/.ssh:/home/project/.ssh
      - /etc/ssh:/etc/ssh
      - /etc/gitconfig:/etc/gitconfig
      - /etc/environment:/etc/environment-vm:ro
    environment:
      NFQ_REMOTE_TOOL_THRIFT: >
        /usr/bin/thrift
```

and don't forget to add thrift to linker

