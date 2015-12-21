# Original Dockerfile stolen from docker-bind and docker-openldap
FROM sameersbn/ubuntu:14.04.20151213
MAINTAINER jpbarto@r9labs.org

ENV WEBMIN_VERSION=1.770

RUN rm -rf /etc/apt/apt.conf.d/docker-gzip-indexes \
 && apt-get update \
 && DEBIAN_FRONTEND=noninteractive apt-get install -y perl libnet-ssleay-perl openssl \
      libauthen-pam-perl libpam-runtime libio-pty-perl \
      apt-show-versions python \
 && wget "http://prdownloads.sourceforge.net/webadmin/webmin_${WEBMIN_VERSION}_all.deb" -P /tmp/ \
 && dpkg -i /tmp/webmin_${WEBMIN_VERSION}_all.deb \
 && rm -rf /tmp/webmin_${WEBMIN_VERSION}_all.deb \
 && rm -rf /var/lib/apt/lists/*

COPY entrypoint.sh /sbin/entrypoint.sh
RUN chmod 755 /sbin/entrypoint.sh

EXPOSE 389/tcp 636/tcp 10000/tcp
ENTRYPOINT ["/sbin/entrypoint.sh"]
