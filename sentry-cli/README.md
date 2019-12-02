## sentry.io toolbox

see https://docs.sentry.io/cli/


### Configuration
Available binary paths for export:

- /usr/local/bin/sentry-cli

### Sample configuration
```
version: '2.4'
services:
  sentry:
    image: nfqlt/sentry-cli
    volumes:
      - './src:/home/project/src'
      - /tmp

  dev:
    image: nfqlt/php73-dev
    volumes_from:
      - service:sentry:rw
    volumes:
      - './src:/home/project/src'
      - '/home/project/.ssh:/home/project/.ssh'
      - '/etc/ssh:/etc/ssh'
      - '/etc/gitconfig:/etc/gitconfig'
      - '/etc/environment:/etc/environment-vm:ro'
    environment:
      NFQ_REMOTE_TOOL_SENTRY: >
        /usr/local/bin/sentry-cli
```

