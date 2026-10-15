## MongoDB 3.2

### Sample configuration

```
version: '2.4'
services:
  mongo:
    image: nfqlt/mongo50
    ports:
      - "10.24.0.0:27017:27017"
    volumes_from:
      - service:mongoVol:rw


  mongoVol:
    image: nfqlt/mongo50-data
    volumes:
      - /var/lib/mongodb

```
