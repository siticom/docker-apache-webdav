#!/bin/sh

chown www-data:www-data /webdav
chmod 750 /webdav

exec /usr/sbin/apache2 -DFOREGROUND