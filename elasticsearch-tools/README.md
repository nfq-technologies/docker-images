## elasticsearch-tools

### List of tools

* head - A web front end for an Elasticsearch cluster


### Sample configuration
```
version '2.1'
services:
  elasticsearch:
    image: nfqlt/elasticsearch51
    network_mode: bridge
    ports:
      - "10.24.0.0:9200:9200"
    volumes_from:
      - service:elasticsearchVol:rw


  elasticsearchVol:
    image: nfqlt/elasticsearch51-data
    network_mode: bridge
    volumes:
      - /var/elasticsearch/data


  elasticsearchTools:
    image: nfqlt/elasticsearch-tools
    network_mode: bridge
    ports:
      - "10.24.0.0:9100:80"
    links:
      - elasticsearch


  linker:
    image: nfqlt/linker17ce
    network_mode: bridge
    volumes:
      - /run/docker.sock:/run/docker.sock

```

