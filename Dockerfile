FROM ubuntu:18.04
LABEL maintainer="Lukas Steiner <lukas.steiner@siticom.de>"

ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2
ENV APACHE_PID_FILE /var/run/apache2.pid
ENV APACHE_LOCK_DIR /var/lock/apache2
ENV APACHE_RUN_DIR /var/run/apache2

ARG apache_version="2.4.29-1ubuntu4.6"
LABEL apache_version=${apache_version}

RUN apt-get update \
    && apt-get install -y apache2=${apache_version} apache2-utils \
    && a2enmod dav dav_fs headers \
    && a2dissite 000-default \
    && echo TransferLog /dev/stdout >> /etc/apache2/apache2.conf \
    && echo ErrorLog /dev/stderr >> /etc/apache2/apache2.conf \
    && echo 'ServerName ${VIRTUAL_HOST}' >> /etc/apache2/apache2.conf \
    && mkdir ${APACHE_RUN_DIR} \
    && chown ${APACHE_RUN_USER}:${APACHE_RUN_GROUP} ${APACHE_RUN_DIR}

COPY dav.conf /etc/apache2/sites-enabled/dav.conf
COPY entrypoint.sh /entrypoint.sh

EXPOSE 80
VOLUME /webdav

CMD /entrypoint.sh