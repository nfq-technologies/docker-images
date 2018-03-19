## fontforge toolbox

### Info
This is an image of fontforge + ttfautohint  in toolbox format

### Configuration
Available binary paths for export:

- /usr/bin/fontforge
- /usr/bin/ttfautohint


### Sample configuration
```
version: '2.1'
services:
  fontforge:
    image: nfqlt/fontforge
    network_mode: bridge
    volumes:
      - ./src:/home/project/src
      - /tmp
  
  node:
    image: nfqlt/node4
    network_mode: bridge
    volumes_from:
      - service:fontforge:rw
    environment:
      NFQ_REMOTE_TOOL_FONTFORGE: >
        /usr/bin/ttfautohint
        /usr/bin/fontforge
  
  dev:
    image: nfqlt/php56-dev
    network_mode: bridge
    volumes_from:
      - service:fontforge:rw
    volumes:
      - ./src:/home/project/src
      - /home/project/.ssh:/home/project/.ssh
      - /etc/ssh:/etc/ssh
      - /etc/gitconfig:/etc/gitconfig
      - /etc/environment:/etc/environment-vm:ro
    environment:
      NFQ_REMOTE_TOOL_NODE: >
        /usr/bin/npm
        /usr/bin/node
        /usr/bin/grunt
```

