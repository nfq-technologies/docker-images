## elasticsearch 5.6

### Sample configuration

```
version: '2.4'
services:
  elasticsearch:
    image: nfqlt/elasticsearch56
    ports:
      - "10.24.0.0:9200:9200"
    volumes_from:
      - service:elasticsearchVol:rw
    environment:
      NFQ_ENABLE_ELASTIC_MODULES: 'analysis-icu'


  elasticsearchVol:
    image: nfqlt/elasticsearch56-data
    volumes:
      - /var/elasticsearch/data

```

