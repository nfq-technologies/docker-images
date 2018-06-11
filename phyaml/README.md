## Phyaml toolbox

### Info
This image is used to perform yaml files manipulation using phyaml tool.


### Sample configuration
```
version: '2.1'
services:
  phyaml:
    image: nfqlt/phyaml
    network_mode: bridge
    volumes:
      - /tmp
      - ./src:/home/project/src


  dev:
    image: nfqlt/php70-dev
    network_mode: bridge
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
    image: nfqlt/linker17ce
    network_mode: bridge
    volumes:
      - /run/docker.sock:/run/docker.sock
```

