## Proxy

### Info
Purpose of this image is to provide transparent proxy, proxying all __dev__ tld requests to __web__ image, and all others to pass thru.

### Limitations
SSL (https) connections are not supported

### Configuration
This image is build on __nginx16__ image and forwards port __80__

### Sample configuration
```
proxy:
  image: docker.nfq.lt/nfqlt/proxy
  ports:
    - "10.24.3.1:8080:80"
  links:
    - web
```

