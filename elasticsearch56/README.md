## elasticsearch 5.6

### Sample configuration

```
version: '2.1'
services:
  elasticsearch:
    image: nfqlt/elasticsearch56
    network_mode: bridge
    ports:
      - "10.24.0.0:9200:9200"
    volumes_from:
      - service:elasticsearchVol:rw
    environment:
      NFQ_ENABLE_ELASTIC_MODULES: 'analysis-icu'


  elasticsearchVol:
    image: nfqlt/elasticsearch56-data
    network_mode: bridge
    volumes:
      - /var/elasticsearch/data

```

