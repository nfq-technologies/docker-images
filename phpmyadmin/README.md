## PHPMyAdmin

### Environment options

* NFQ_DB_USER: db_username
* NFQ_DB_PASSWORD: db_pass

Defaults to project:project


### Sample configuration
```
version '2.4'
services:
  phpmyadmin:
    image: nfqlt/phpmyadmin
    ports:
      - "10.24.0.0:1081:80"

  linker:
    image: nfqlt/linker18ce
    volumes:
      - /run/docker.sock:/run/docker.sock

```

