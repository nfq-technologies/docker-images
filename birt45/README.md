## Eclipse BIRT runtime v4.5.x

### Info
Purpose of this image is to provide Eclipse BIRT viewer weblet,
served thru Apache Tomcat v8


### Sample configuration
```
version: '2.4'
services:
  birt:
    image: nfqlt/birt45
    ports:
      - "10.24.3.1:8080:8080"
```

