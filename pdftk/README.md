## PDFtk toolbox

### Info
This is an image of pdftk from Debian source in toolbox format. A handy
tool for manipulating PDF

### Configuration
Available binary paths for export:

- /usr/bin/pdftk

### Sample configuration
```
version: '2.4'
services:
  pdftk:
    image: nfqlt/pdftk
    volumes:
      - './src:/home/project/src'
      - /tmp

  dev:
    image: nfqlt/php73-dev
    volumes_from:
      - service:pdftk:rw
    volumes:
      - ./src:/home/project/src
      - /home/project/.ssh:/home/project/.ssh
      - /etc/ssh:/etc/ssh
      - /etc/gitconfig:/etc/gitconfig
      - /etc/environment:/etc/environment-vm:ro
    environment:
      NFQ_REMOTE_TOOL_PDFTK: >
        /usr/bin/pdftk

  linker:
    image: nfqlt/linker18ce
    volumes:
      - /run/docker.sock:/run/docker.sock
```

### Usage


### Limitations

As this image works on "toolbox" approach keep in mind that only __/tmp__
and __/home/project/src__ (from containers perspective) paths are accessible
to pdftk

