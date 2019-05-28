## elasticsearch 6.8

### Sample configuration

```
version: '2.1'
services:
  elasticsearch:
    image: nfqlt/elasticsearch68
    network_mode: bridge
    ports:
      - "10.24.0.0:9200:9200"
    volumes_from:
      - service:elasticsearchVol:rw
    environment:
      NFQ_ENABLE_ELASTIC_MODULES: 'analysis-icu'


  elasticsearchVol:
    image: nfqlt/elasticsearch68-data
    network_mode: bridge
    volumes:
      - /var/elasticsearch/data

```

