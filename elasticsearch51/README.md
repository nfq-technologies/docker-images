## elasticsearch 5.1

### Sample configuration

```
elasticsearch:
  image: docker.nfq.lt/nfqlt/elasticsearch51
  ports:
    - "10.24.0.0:9200:9200"
  volumes_from:
    - elasticsearchVol
  environment:
    NFQ_ENABLE_ELASTIC_MODULES: 'analysis-icu'


elasticsearchVol:
  image: docker.nfq.lt/nfqlt/elasticsearch51-data
  volumes:
    - /var/elasticsearch/data

```

