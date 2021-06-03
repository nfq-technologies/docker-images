## sonar-qube v7.x


### Sample configuration
```
version: '2.4'
services:
  sonarqube:
    image: nfqlt/sonarqube7
    ports:
      - '9000:9000'
    links:
      - postgres


  postgres:
    image: nfqlt/postgres12
    ports:
      - '5432:5432'
    volumes_from:
      - 'service:postgresVol:rw'


  postgresVol:
    image: nfqlt/postgres12-data
    volumes:
      - /var/lib/postgres/data/pgdata


  sonar:
    image: nfqlt/sonar-scanner-cli4
    volumes:
      - './src:/home/project/src'
      - /tmp

  dev:
    image: nfqlt/php73-dev
    volumes_from:
      - service:sonar:rw
    volumes:
      - './src:/home/project/src'
      - '/home/project/.ssh:/home/project/.ssh'
      - '/etc/ssh:/etc/ssh'
      - '/etc/gitconfig:/etc/gitconfig'
      - '/etc/environment:/etc/environment-vm:ro'
    environment:
      NFQ_REMOTE_TOOL_SONAR: >
        /usr/bin/sonar-scanner
```

