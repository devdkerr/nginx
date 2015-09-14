Dockerized Nginx
========================================

A dockerized Nginx service, with Monit monitoring.

Docker Run
----------------------------------------

```bash
docker run -d -p 2812 -p 80:80 -v data/nginx:/usr/share/nginx/html:ro devdkerr/nginx
```

Docker-Compose Run
----------------------------------------

```yaml
nginx:
    image: devdkerr/nginx
    ports:
     - "2812"
     - "80:80"
    volumes:
     - data/nginx:/usr/share/nginx/html:ro
```
