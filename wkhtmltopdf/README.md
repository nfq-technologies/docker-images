## Wkhtmltopdf toolbox

### Info
This is an image of wkhtmltopdf Debian source in toolbox format, with included xvfb framebuffer

### Configuration
Available binary paths for export:

- /usr/bin/xvfb-run
- /usr/bin/wkhtmltopdf

### Sample configuration
```
version: '2.1'
services:
  wkhtmltopdf:
    image: nfqlt/wkhtmltopdf
    network_mode: bridge
    volumes:
      - './src:/home/project/src'
      - /tmp

  dev:
    image: nfqlt/php56-dev
    network_mode: bridge
    volumes_from:
      - services:wkhtmltopdf:rw
    volumes:
      - ./src:/home/project/src
      - /home/project/.ssh:/home/project/.ssh
      - /etc/ssh:/etc/ssh
      - /etc/gitconfig:/etc/gitconfig
      - /etc/environment:/etc/environment-vm:ro
    environment:
      NFQ_REMOTE_TOOL_WKHTMLTOPDF: >
        /usr/bin/xvfb-run
        /usr/bin/wkhtmltopdf

  linker:
    image: nfqlt/linker17ce
    network_mode: bridge
    volumes:
      - /run/docker.sock:/run/docker.sock
```

### Usage
__wkhtmltopdf__ will not on its own, it needs an accessible frame buffer. For this requirement this has __xvfb-run__ virtual frame buffer built-in

To run wkhtmltopdf with vfb just prepend xvfb-run command:
```
xvfb-run wkhtmltopdf http://www.google.com test.pdf
```

You can also pass additional parameters to X server itself like screen size, rezolution etc.:
```
xvfb-run -a -s "-screen 0 640x480x16" wkhtmltopdf http://www.google.com test.pdf
```

### Limitations
As this image works on "toolbox" approach keep in mind that only __/tmp__ and __/home/project/src__ (from containers perspective) paths are accessible to wkhtmltopdf

