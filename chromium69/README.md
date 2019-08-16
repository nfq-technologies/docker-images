## Chromium v69.x started in headless mode and remote debuging

### Info
 - Port: 9222

### Sample configuration
```
version: '2.4'
services:

  chromium:
    image: nfqlt/chromium69
    volumes:
      - './src:/home/project/src'
      - /tmp


  dev:
    image: nfqlt/php73-dev
    volumes_from:
      - service:chromium:rw
    volumes:
      - './src:/home/project/src'
      - '/home/project/.ssh:/home/project/.ssh'
      - '/etc/ssh:/etc/ssh'
      - '/etc/gitconfig:/etc/gitconfig'
      - '/etc/environment:/etc/environment-vm:ro'
```

