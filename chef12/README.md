## Chef toolbox

### Info
This is an image of Chefdk 1.2.22 version

### Global npm packages
This image has pre-installed Chef development tools

 - Chef
 - Berkshelf
 - Test Kitchen
 - ChefSpec
 - Foodcritic
 - Delivery CLI
 - Push Jobs Client

### Configuration
Available binary paths for export:

- /usr/bin/chef
- /usr/bin/chef-solo
- /usr/bin/chef-apply
- /usr/bin/chef-client
- /usr/bin/chef-shell

### Usage
For help with Chef visit project [homepage](https://github.com/chef/chef-dk) for documentation and guides.

### Sample configuration
```
version: '2.4'
services:
  dev:
    image: nfqlt/php73-dev
    volumes:
      - './src:/home/project/src'
    volumes_from:
      - 'service:cheftools:rw'
    environment:
      NFQ_REMOTE_TOOL_CHEFTOOLS: >
        /usr/bin/chef
        /usr/bin/chef-solo
        /usr/bin/chef-apply
        /usr/bin/chef-client
        /usr/bin/chef-shell
  cheftools:
    image: nfqlt/chef12
    volumes_from:
      - './src:/home/project/src'
      - /tmp
```
