## Node.js toolbox

### Info
This is an image of Node.js 22.x version  in toolbox format

### Global npm packages
This image has pre-installed npm global packages

 - yarn
 - gulp-cli
 - grunt-cli
 - sass
 - bower
 - typescript
 - tslint

### Configuration
Available binary paths for export:

- /usr/bin/node
- /usr/bin/npm
- /usr/bin/yarn
- /usr/bin/gulp
- /usr/bin/grunt
- /usr/bin/sass
- /usr/bin/bower
- /usr/bin/uglifycss
- /usr/bin/uglifyjs
- /usr/bin/tsc
- /usr/bin/tslint
- /usr/bin/npx

### Sample configuration
```
version: '2.4'
services:
  node:
    image: nfqlt/node22
    volumes:
      - './src:/home/project/src'
      - /tmp

  dev:
    image: nfqlt/dev
    volumes_from:
      - service:node:rw
    volumes:
      - './src:/home/project/src'
      - '/home/project/.ssh:/home/project/.ssh'
      - '/etc/ssh:/etc/ssh'
      - '/etc/gitconfig:/etc/gitconfig'
      - '/etc/environment:/etc/environment-vm:ro'
    environment:
      NFQ_REMOTE_TOOL_NODE: >
        /usr/bin/yarn
        /usr/bin/node
        /usr/bin/grunt
```

