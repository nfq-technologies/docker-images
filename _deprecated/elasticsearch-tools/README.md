## elasticsearch-tools

### List of tools

* head - A web front end for an Elasticsearch cluster


### Sample configuration
```
version '2.4'
services:
  elasticsearch:
    image: nfqlt/elasticsearch56
    ports:
      - "10.24.0.0:9200:9200"
    volumes_from:
      - service:elasticsearchVol:rw


  elasticsearchVol:
    image: nfqlt/elasticsearch56-data
    volumes:
      - /var/elasticsearch/data


  elasticsearchTools:
    image: nfqlt/elasticsearch-tools
    ports:
      - "10.24.0.0:9100:80"
    links:
      - elasticsearch


  linker:
    image: nfqlt/linker18ce
    volumes:
      - /run/docker.sock:/run/docker.sock

```

