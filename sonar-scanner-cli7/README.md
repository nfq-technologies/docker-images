## sonar-scanner-cli v7.x toolbox

### export paths

- /usr/bin/sonar-scanner

### Sample configuration
```
version: '2.4'
services:
  sonar:
    image: nfqlt/sonar-scanner-cli7
    volumes:
      - './src:/home/project/src'
      - /tmp

  dev:
    image: nfqlt/php73-dev
    volumes_from:
      - service:sonar:rw
    volumes:
      - './src:/home/project/src'
      - '/home/project/.ssh:/home/project/.ssh'
      - '/etc/ssh:/etc/ssh'
      - '/etc/gitconfig:/etc/gitconfig'
      - '/etc/environment:/etc/environment-vm:ro'
    environment:
      NFQ_REMOTE_TOOL_SONAR: >
        /usr/bin/sonar-scanner
```

