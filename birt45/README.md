## Eclipse BIRT runtime v4.5.x

### Info
Purpose of this image is to provide Eclipse BIRT viewer weblet,
served thru Apache Tomcat v8


### Sample configuration
```
version: '2.1'
services:
  birt:
    image: nfqlt/birt45
    network_mode: bridge
    ports:
      - "10.24.3.1:8080:8080"
```

