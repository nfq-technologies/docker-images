## QPDF toolbox

### Info
This is a prebuilt Docker image for QPDF, a tool for performing transformations on PDF files.

### Configuration
Available binary paths for export:

- /usr/local/bin/qpdf

### Sample configuration
```
version: '2.4'
services:
  qpdf:
    image: nfqlt/qpdf
    volumes:
      - './src:/home/project/src'
      - /tmp

  dev:
    image: nfqlt/php83-dev
    volumes_from:
      - 'qpdf:rw'
    volumes:
      - './src:/home/project/src'
    environment:
      NFQ_REMOTE_TOOL_QPDF: /usr/local/bin/qpdf
  
```

### Limitations
As this image works on "toolbox" approach keep in mind that only /tmp
and /home/project/src (from containers perspective) paths are accessible
to qpdf
