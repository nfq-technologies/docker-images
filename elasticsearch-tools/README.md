## elasticsearch-tools

### List of tools

* head - A web front end for an Elasticsearch cluster


### Sample configuration
```
elasticsearch:
  image: nfqlt/elasticsearch51
  ports:
    - "10.24.0.0:9200:9200"
  volumes_from:
    - elasticsearchVol


elasticsearchVol:
  image: nfqlt/elasticsearch51-data
  volumes:
    - /var/elasticsearch/data


elasticsearchTools:
  image: nfqlt/elasticsearch-tools
  ports:
    - "10.24.0.0:9100:80"
  links:
    - elasticsearch


linker:
  image: nfqlt/linker17
  volumes:
    - /run/docker.sock:/run/docker.sock
  links:
    - web
    - dev
    - elasticsearch
    - elasticsearchTools

```

