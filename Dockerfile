FROM nginx:stable

RUN echo "deb http://ftp.debian.org/debian jessie-backports main" > /etc/apt/sources.list.d/jessie.backports.list

ENV SUPERVISOR_VERSION 3.3.0

RUN set -x \
    cron \
    ca-certificates \
    dnsmasq \
    && apt-get install --no-install-recommends -yqq certbot -t jessie-backports \
    && wget https://github.com/Supervisor/supervisor/archive/${SUPERVISOR_VERSION}.tar.gz \
    && tar -xvf ${SUPERVISOR_VERSION}.tar.gz \
    && cd supervisor-${SUPERVISOR_VERSION} && python setup.py install \
    && apt-get clean autoclean && apt-get autoremove -y \
    && rm -rf /var/lib/apt/lists/*

COPY supervisord.conf /etc/supervisord.conf
COPY certs.sh /
COPY bootstrap.sh /

RUN mkdir /jail

EXPOSE 80 443

VOLUME /etc/letsencrypt

COPY haproxy.cfg /usr/local/etc/haproxy/haproxy.cfg

ENTRYPOINT ["/bootstrap.sh"]
