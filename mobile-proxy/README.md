## Proxy

### Info
Purpose of this image is to provide transparent proxy, proxying all __test__
 tld requests to __web__ image, and all others to pass thru. So that this
 image could be used as a proxy on mobile device and get you access to your
 project.

### Limitations
SSL (https) connections are not supported

### Configuration
This image is build on __nginx110__ image and forwards port __80__

### Sample configuration
```
version: '2.1'
services:
  proxy:
    image: nfqlt/mobile-proxy
    network_mode: bridge
    ports:
      - "10.24.3.1:8080:80"
    links:
      - web
```

