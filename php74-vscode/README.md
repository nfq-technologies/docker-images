## php dev env with vscode

### Info

This image adds vscode to your usual dev container. vscode window should
appear on project startup right after project-started notice. This should
not affect other aspects of dev container behavior. In case you dont want
to use vscode you can just close the window with no effect on the project,
but you will need to restart project to get it back. For this reason,
projects can be upgraded to use this image by default.


### How to upgrade

To upgrade from standard php*-dev image you need to change three things

change image you are using in dev container
```
  dev:
    image: nfqlt/php74-vscode
```

add these volumes
```
    volumes:
      - '/home/project/.Xauthority:/home/project/.Xauthority'
      - '/tmp/.X11-unix:/tmp/.X11-unix'
```


and pass your DISPLAY environment variable like this
```
    environment:
      DISPLAY: $DISPLAY
```



### Sample configuration

```
version: '2.4'
services:

  dev:
    image: nfqlt/php74-vscode
    shm_size: 256M
    volumes:
      - './src:/home/project/src'
      - '/home/project/.ssh:/home/project/.ssh'
      - '/etc/ssh:/etc/ssh'
      - '/etc/gitconfig:/etc/gitconfig'
      - '/etc/environment:/etc/environment-vm:ro'
      - '/vagrant/bash_custom:/home/project/.bash_custom'
      - '/home/project/.Xauthority:/home/project/.Xauthority'
      - '/tmp/.X11-unix:/tmp/.X11-unix'
    environment:
      DISPLAY: $DISPLAY
      NFQ_ENABLE_PHP_MODULES: 'xml dom tokenizer ctype curl json iconv pdo mbstring xmlreader xmlwriter xdebug'
      NFQ_PROJECT_ROOT: /home/project/src
      NFQ_PROJECT_GIT_REPO: 'repo'
      NFQ_PROJECT_GIT_BRANCH: develop
      NFQ_INIT_SCRIPT: tools/docker/develop_init.sh
      NFQ_REMOTE_TOOL_PACKAGER: >
        /usr/local/bin/package-deb

```

