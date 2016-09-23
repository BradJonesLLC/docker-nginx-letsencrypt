# Dockerized Nginx with Let's Encrypt

[![Docker Automated buil](https://img.shields.io/docker/automated/bradjonesllc/docker-nginx-letsencrypt.svg?maxAge=2592000)](https://hub.docker.com/r/bradjonesllc/docker-nginx-letsencrypt/)

This container provides an Nginx application with Let's Encrypt certificates
generated at startup, as well as renewed (if necessary) and Nginx gracefully restarted.

## Usage

```
docker run \
    -e CERTS=my.domain,my.other.domain \
    -e EMAIL=my.email@my.domain \
    -v /etc/ssl/dhparam:/etc/ssl/dhparam \
    -v /srv/letsencrypt:/etc/letsencrypt \
    -p 80:80 -p 443:443
    bradjonesllc/docker-nginx-letsencrypt
```

You will almost certainly want to create an image `FROM bradjonesllc/docker-nginx-letsencrypt` this image or
mount your Nginx config at `/etc/nginx/nginx.conf`.

## Super-simple microservices pattern

This base container creates a symlink for the "first" Let's Encrypt certificate it finds on initial startup,
and it's used as the default certificate for Nginx SSL. So, without having to specify in code the domain name,
you can use a DNS alias (e.g., in a Docker overlay network) to create a zero-downtime upgrade proxy:

```
resolver 127.0.0.1; # The bundled dnsmasq daemon

server {
    listen 443 ssl;
    location / {
        set $backend servicename;
        proxy_pass http://$backend;
    }
}
```

### License and Copyright

&copy; Brad Jones LLC, Licensed under GPL-2.
