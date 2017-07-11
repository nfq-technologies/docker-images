### https-dev

This is an proxy based on nginx that will handle ssl (https) connections, and will proxy traffic to web container

__NOTE:__ This is just for testing locally, it uses self signed certificates (regenerated on launch).
And all merge requests opened for project with this image __will be declined__


### Example:

```
https-dev:
  image: docker.nfq.lt/nfqlt/https-dev
  ports:
    - '192.168.1.257:443:443'
  links:
    - web
```

