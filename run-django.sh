#!/bin/sh
set -e

# Copy uwsgi_params into the required place
cp /tmp/uwsgi_params /var/site/

# Run nginx in the background
nginx 

python manage.py collectstatic
cp -R static ../

uwsgi --wsgi-file wsgi.py -s /var/run/wsgi.sock --chmod-socket=666
