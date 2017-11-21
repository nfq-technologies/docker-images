## Node.js toolbox

### Info
This is an image of Node.js LTS version  in toolbox format

### Global npm packages
This image has pre-installed npm global packages

 - yarn
 - gulp-cli
 - grunt-cli
 - node-sass
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
- /usr/bin/node-sass
- /usr/bin/bower
- /usr/bin/uglifycss
- /usr/bin/uglifyjs
- /usr/bin/tsc
- /usr/bin/tslint

### Sample configuration
```
node:
  image: nfqlt/node8
  volumes:
    - './src:/home/project/src'
    - /tmp

dev:
  image: nfqlt/php70-dev
  volumes_from:
    - node
  volumes:
    - './src:/home/project/src'
    - '/home/project/.ssh:/home/project/.ssh'
    - '/etc/ssh:/etc/ssh'
    - '/etc/gitconfig:/etc/gitconfig'
    - '/etc/environment:/etc/environment-vm:ro'
  environment:
    NFQ_REMOTE_TOOL_NODE: >
      /usr/bin/npm
      /usr/bin/node
      /usr/bin/grunt
```

