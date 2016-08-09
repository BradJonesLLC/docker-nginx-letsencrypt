# Dockerized Nginx with Let's Encrypt

This container provides an Nginx application with Let's Encrypt certificates
generated at startup, as well as renewed (if necessary) once a week.

## Usage

```
docker run \
    -e CERTS=my.domain,my.other.domain \
    -e EMAIL=my.email@my.domain \
    -v /etc/letsencrypt:/srv/letsencrypt \
    -p 80:90 -p 443:443
    bradjonesllc/docker-nginx-letsencrypt
```

You will almost certainly want to create an image `FROM` this image or
mount your Nginx config at `/etc/nginx/nginx.conf`.

### License and Copyright

&copy; Brad Jones LLC, Licensed under GPL-2.
