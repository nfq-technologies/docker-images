## Ghostscript toolbox

### Info
This is an image of ghostscript Debian source in toolbox format

### Configuration
Available binary paths for export:

- /usr/bin/dvipdf
- /usr/bin/eps2eps
- /usr/bin/font2c
- /usr/bin/ghostscript
- /usr/bin/gs
- /usr/bin/gsbj
- /usr/bin/gsdj
- /usr/bin/gsdj500
- /usr/bin/gslj
- /usr/bin/gslp
- /usr/bin/gsnd
- /usr/bin/pdf2dsc
- /usr/bin/pdf2ps
- /usr/bin/pf2afm
- /usr/bin/pfbtopfa
- /usr/bin/pphs
- /usr/bin/printafm
- /usr/bin/ps2ascii
- /usr/bin/ps2epsi
- /usr/bin/ps2pdf
- /usr/bin/ps2pdf12
- /usr/bin/ps2pdf13
- /usr/bin/ps2pdf14
- /usr/bin/ps2pdfwr
- /usr/bin/ps2ps
- /usr/bin/ps2ps2
- /usr/bin/ps2txt
- /usr/bin/wftopfa

### Sample configuration
```
version: '2.4'
services:
  ghostscript:
    image: nfqlt/ghostscript
    volumes:
      - './src:/home/project/src'
      - /tmp

  dev:
    image: nfqlt/php73-dev
    volumes_from:
      - service:ghostscript:rw
    volumes:
      - ./src:/home/project/src
      - /home/project/.ssh:/home/project/.ssh
      - /etc/ssh:/etc/ssh
      - /etc/gitconfig:/etc/gitconfig
      - /etc/environment:/etc/environment-vm:ro
    environment:
      NFQ_REMOTE_TOOL_GHOSTSCRIPT: >
        /usr/bin/gs

  linker:
    image: nfqlt/linker18ce
    volumes:
      - /run/docker.sock:/run/docker.sock
```

### Limitations
As this image works on "toolbox" approach keep in mind that only __/tmp__ and __/home/project/src__ (from containers perspective) paths are accessible to ghostscript

