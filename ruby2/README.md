## Ruby 2 toolbox

### Info
This is an image of ruby 2 version in toolbox format

### Global gems installed
This image has pre-installed gems

 - bundler
 - sass
 - compass
 - zurb-foundation

### Configuration
Available binary paths for export:

- /usr/bin/ruby
- /usr/bin/gem
- /usr/local/bin/bundle
- /usr/local/bin/sass
- /usr/local/bin/compass

### Sample configuration
```
version: '2.4'
services:
  ruby:
    image: nfqlt/ruby2
    volumes:
      - ./src:/home/project/src
      - /tmp

  dev:
    image: nfqlt/php73-dev
    volumes_from:
      - service:ruby:rw
    volumes:
      - ./src:/home/project/src
      - /home/project/.ssh:/home/project/.ssh
      - /etc/ssh:/etc/ssh
      - /etc/gitconfig:/etc/gitconfig
      - /etc/environment:/etc/environment-vm:ro
    environment:
      NFQ_REMOTE_TOOL_RUBY: >
        /usr/local/bin/bundle
        /usr/local/bin/sass
```

