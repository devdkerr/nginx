FROM ubuntu:trusty
MAINTAINER Daniel R. Kerr <daniel.robert.kerr@gmail.com>

COPY nginx.gpg /root/nginx.gpg
RUN apt-key add /root/nginx.gpg \
 && echo "deb http://nginx.org/packages/ubuntu/ trusty nginx" > /etc/apt/sources.list.d/nginx.list

RUN apt-get update \
 && apt-get install -qq -y monit nginx supervisor \
 && apt-get clean \
 && rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/*

RUN ln -sf /dev/stdout /var/log/nginx/access.log \
 && ln -sf /dev/stderr /var/log/nginx/error.log

COPY nginx.conf /etc/nginx/conf.d/default.conf

COPY monitrc /etc/monit/monitrc
RUN chmod 700 /etc/monit/monitrc \
 && chown root:root /etc/monit/monitrc

VOLUME ["/var/cache/nginx"]

EXPOSE 80 443 2812

COPY supervisord.conf /etc/supervisord.conf
CMD ["/usr/bin/supervisord"]
