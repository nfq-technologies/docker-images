## elasticsearch 6.2

### Sample configuration

```
version: '2.4'
services:
  elasticsearch:
    image: nfqlt/elasticsearch62
    ports:
      - "10.24.0.0:9200:9200"
    volumes_from:
      - service:elasticsearchVol:rw
    environment:
      NFQ_ENABLE_ELASTIC_MODULES: 'analysis-icu'


  elasticsearchVol:
    image: nfqlt/elasticsearch62-data
    volumes:
      - /var/elasticsearch/data

```

