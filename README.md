docker-django
=============

## Building 
    git clone git@github.com:usmanismail/docker-django.git
    cd docker-django
    docker build -t django .
    
## Creating and Setting up a new project 

Note this is only needed if you have not already setup your project through django.

    # Start initial project
    docker run -it -v $PWD:/var/site django django-admin.py startproject mysite
    
    # Add static root
    echo 'STATIC_ROOT = os.path.join(BASE_DIR, "static/")' >> mysite/mysite/settings.py
    
    # collect static files for serving with nginx
    docker run -it -v $PWD:/var/site django python /var/site/mysite/manage.py collectstatic
    
    # If you are using an internal sqlite (the default setup uses this) but you don't want to do this in production.
    docker run -it -v $PWD:/var/site django python /var/site/mysite/manage.py migrate
    
    # Actually run django
    docker run --rm -it -v $PWD:/var/site -p 8000:8000 -e SITE_NAME=mysite django
    
    # Browse to localhost:8000 in a web browser of your choice.
    # note: if you are using boot2docker you should lookup your docker interface by using boot2docker ip
    # and browse to the IP specified by this command instead of localhost
    
    
    
