#!/bin/sh
set -e

# Copy uwsgi_params into the required place
cp /tmp/uwsgi_params /var/site/

# Run nginx in the background
nginx 

# Run wsgi in the foreground
cd /var/site/${SITE_NAME}

python manage.py collectstatic
cp -R static ../

uwsgi --wsgi-file ${SITE_NAME}/wsgi.py -s /var/run/wsgi.sock --chmod-socket=666
