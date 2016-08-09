#!/usr/bin/env bash

if [ -n "$CERTS" ]; then
    certbot certonly --no-self-upgrade -n --text --standalone \
        --standalone-supported-challenges http-01 \
        -d "$CERTS" --keep --agree-tos --email "$EMAIL" \
        || exit 1
fi

# Create a dependable link to the first live cert directory.
ln `ls -1dA /etc/letsencrypt/live/*/ | head -n1` /etc/ssl/le-first

exit 0
