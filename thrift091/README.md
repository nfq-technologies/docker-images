## thrift toolbox

### Info
This is an image of thrift 0.9.1 version in toolbox format


### Configuration
Available binary paths for export:

- /usr/bin/thrift


### Sample configuration
```
thrift:
  image: nfqlt/thrift091
  volumes_from:
    - dev

dev:
  image: nfqlt/php56-dev
  volumes:
    - ./src:/home/project/src
    - /home/project/.ssh:/home/project/.ssh
    - /etc/ssh:/etc/ssh
    - /etc/gitconfig:/etc/gitconfig
    - /etc/environment:/etc/environment-vm:ro
    - /tmp
  environment:
    NFQ_REMOTE_TOOL_THRIFT: >
      /usr/bin/thrift
```

and don't forget to add thrift to linker

