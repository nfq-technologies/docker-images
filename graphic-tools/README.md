## graphic-tools toolbox

### Info
This is an image tools collections for graphic image processing

### Configuration
Available binary paths for export:

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
graphics:
  image: docker.nfq.lt/nfqlt/graphic-tools
  volumes:
    - './src:/home/project/src'
    - /tmp

dev:
  image: docker.nfq.lt/nfqlt/php56-dev
  volumes_from:
    - graphics
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

