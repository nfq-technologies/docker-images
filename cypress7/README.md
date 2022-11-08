## Cypress toolbox

### Info
This is an image of Cypress 7.x version running on electronin toolbox format

### Global npm packages
This image has pre-installed npm global packages

 - cypress

### Configuration
Available binary paths for export:

- /usr/bin/cypress
- /usr/bin/xvfb-run

### Sample configuration
```
version: '2.4'
services:
  cypress:
    image: nfqlt/cypress7
    volumes:
      - './src:/home/project/src'
      - /tmp

  dev:
    image: nfqlt/php81-dev
    volumes_from:
      - service:cypress:rw
    volumes:
      - './src:/home/project/src'
      - '/home/project/.ssh:/home/project/.ssh'
      - '/etc/ssh:/etc/ssh'
      - '/etc/gitconfig:/etc/gitconfig'
      - '/etc/environment:/etc/environment-vm:ro'
    environment:
      NFQ_REMOTE_TOOL_CYPRESS: >
        /usr/local/bin/cypress

  linker:
    image: nfqlt/linker18ce
    volumes:
      - '/run/docker.sock:/run/docker.sock'
```
