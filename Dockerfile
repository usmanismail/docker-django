from centos:7

ADD nginx.repo /etc/yum.repos.d/nginx.repo

RUN yum update -y
RUN yum install -y python python-devel python-setuptools gcc python-psycopg2 postgresql nginx vim
RUN easy_install pip

RUN pip install uwsgi
RUN pip install Django
RUN pip install mezzanine

# Copy nginx configuration into docker
ADD site.conf /etc/nginx/conf.d/site.conf

# Copy uwsgi_params into container, we would need to copy it into project later
ADD uwsgi_params /tmp/uwsgi_params
ADD run-django.sh /usr/bin/run-django.sh

# Expose post 8000
EXPOSE 8000

ENV PYTHONPATH /var/site
CMD ["/usr/bin/run-django.sh"]





