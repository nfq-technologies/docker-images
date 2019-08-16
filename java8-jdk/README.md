## Java 8 development kit toolbox

### Info
This is an image of Java 8 JDK in toolbox format

### Configuration
Available binary paths for export:

- /usr/bin/java
- /usr/bin/javac

### Sample configuration
```
version: '2.4'
services:
  java:
    image: nfqlt/java8-jdk
    volumes:
      - './src:/home/project/src'
      - /tmp

  dev:
    image: nfqlt/php73-dev
    volumes_from:
      - service:java:rw
    volumes:
      - './src:/home/project/src'
      - '/home/project/.ssh:/home/project/.ssh'
      - '/etc/ssh:/etc/ssh'
      - '/etc/gitconfig:/etc/gitconfig'
      - '/etc/environment:/etc/environment-vm:ro'
    environment:
      NFQ_REMOTE_TOOL_JAVA: >
        /usr/bin/java
        /usr/bin/javac
```

