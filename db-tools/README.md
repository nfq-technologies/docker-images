## DB-Tools toolbox

### Info
This is an image of various DB cli tools in toolbox format

### Installed packages
This image has pre-installed debian packages for db's management

 - sqlite3
 - mdbtools (MS Access)
 - mysql-client (mariadb-client)

### Configuration
Available binary paths for export:

- /usr/bin/sqldiff
- /usr/bin/sqlite3
- /usr/bin/mdb-array
- /usr/bin/mdb-export
- /usr/bin/mdb-header
- /usr/bin/mdb-hexdump
- /usr/bin/mdb-parsecsv
- /usr/bin/mdb-prop
- /usr/bin/mdb-schema
- /usr/bin/mdb-sql
- /usr/bin/mdb-tables
- /usr/bin/mdb-ver
- /usr/bin/mysql

### Sample configuration
```
version: '2.4'
services:
  dbtools:
    image: nfqlt/db-tools
    volumes:
      - './src:/home/project/src'
      - /tmp

  dev:
    image: nfqlt/php73-dev
    volumes_from:
      - service:dbtools:rw
    volumes:
      - './src:/home/project/src'
      - '/home/project/.ssh:/home/project/.ssh'
      - '/etc/ssh:/etc/ssh'
      - '/etc/gitconfig:/etc/gitconfig'
      - '/etc/environment:/etc/environment-vm:ro'
    environment:
      NFQ_REMOTE_TOOL_DBTOOLS: >
        /usr/bin/sqlite3
        /usr/bin/mdb-sql
        /usr/bin/mysql
```

