#!/bin/bash

set -u
set -e

PROJECT=$1
apt-get install -q -y nginx
rm -f /etc/nginx/sites-enabled/default
cp /vagrant/config/nginx-${PROJECT}.conf /etc/nginx/sites-available/$PROJECT
ln -fs /etc/nginx/sites-available/$PROJECT /etc/nginx/sites-enabled/$PROJECT

if ( service nginx configtest > /dev/null 2>&1 )
then
    service nginx reload
else
    echo "nginx config error"
    exit 1
fi
