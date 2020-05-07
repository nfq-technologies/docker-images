## graphic-tools toolbox

### Info
This is an image tools collections for graphic image processing

### Configuration
Available binary paths for export:

- /usr/bin/cwebp
- /usr/bin/optipng
- /usr/bin/pngquant
- /usr/bin/pngcrush
- /usr/bin/jpegoptim
- /usr/bin/cjpeg
- /usr/bin/djpeg
- /usr/bin/exifautotran
- /usr/bin/jpegexiforient
- /usr/bin/jpegtran
- /usr/bin/rdjpgcom
- /usr/bin/tjbench
- /usr/bin/wrjpgcom


### Sample configuration

```
version: '2.4'
services:
  graphics:
    image: nfqlt/graphic-tools
    volumes:
      - './src:/home/project/src'
      - /tmp

  dev:
    image: nfqlt/php73-dev
    volumes_from:
      - service:graphics:rw
    volumes:
      - './src:/home/project/src'
      - '/home/project/.ssh:/home/project/.ssh'
      - '/etc/ssh:/etc/ssh'
      - '/etc/gitconfig:/etc/gitconfig'
      - '/etc/environment:/etc/environment-vm:ro'
    environment:
      NFQ_REMOTE_TOOL_GRAPHICS: >
        /usr/bin/optipng
        /usr/bin/pngquant
```

