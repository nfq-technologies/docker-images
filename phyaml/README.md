## Phyaml toolbox

### Info
This image is used to perform yaml files manipulation using phyaml tool.


### Sample configuration
```
version: '2.4'
services:
  phyaml:
    image: nfqlt/phyaml
    volumes:
      - /tmp
      - ./src:/home/project/src


  dev:
    image: nfqlt/php73-dev
    volumes_from:
      - service:phyaml:rw
    volumes:
      - ./src:/home/project/src
      - /home/project/.ssh:/home/project/.ssh
      - /etc/ssh:/etc/ssh
      - /etc/gitconfig:/etc/gitconfig
      - /etc/environment:/etc/environment-vm:ro
    environment:
      NFQ_REMOTE_TOOL_PHYAML: >
        /usr/bin/phyaml


  linker:
    image: nfqlt/linker18ce
    volumes:
      - /run/docker.sock:/run/docker.sock
```

