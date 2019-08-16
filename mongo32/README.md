## MongoDB 3.2

### Sample configuration

```
version: '2.4'
services:
  mongo:
    image: nfqlt/mongo32
    ports:
      - "10.24.0.0:27017:27017"
    volumes_from:
      - service:mongoVol:rw


  mongoVol:
    image: nfqlt/mongo32-data
    volumes:
      - /var/lib/mongodb

```
