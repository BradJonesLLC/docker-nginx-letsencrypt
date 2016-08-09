#!/usr/bin/env bash

if [ ! -f /etc/ssl/certs/dhparam.pem ]; then cd /etc/ssl/certs && openssl dhparam -out dhparam.pem 2048; fi

/certs.sh && supervisord -n
