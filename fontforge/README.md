## fontforge toolbox

### Info
This is an image of fontforge + ttfautohint  in toolbox format

### Configuration
Available binary paths for export:

- /usr/bin/fontforge
- /usr/bin/ttfautohint


### Sample configuration
```
fontforge:
  image: docker.nfq.lt/nfqlt/fontforge
  volumes:
    - ./src:/home/project/src
    - /tmp

node:
  image: docker.nfq.lt/nfqlt/node4
  volumes_from:
    - fontforge
  environment:
    NFQ_REMOTE_TOOL_FONTFORGE: >
      /usr/bin/ttfautohint
      /usr/bin/fontforge

dev:
  image: docker.nfq.lt/nfqlt/php56-dev
  volumes_from:
    - fontforge
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

