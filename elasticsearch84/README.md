## elasticsearch 8.4.x

### Sample configuration

```
version: '2.4'
services:
  elasticsearch:
    image: nfqlt/elasticsearch84
    ports:
      - "10.24.0.0:9200:9200"
    environment:
      NFQ_ENABLE_ELASTIC_MODULES: 'analysis-icu'

```

