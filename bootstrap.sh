#!/usr/bin/env bash
\
if [ ! -f /etc/ssl/dhparam/dhparam.pem ]; then mkdir -p /etc/ssl/dhparam && cd /etc/ssl/dhparam && openssl dhparam -out dhparam.pem 2048; fi

/certs.sh && supervisord -n
