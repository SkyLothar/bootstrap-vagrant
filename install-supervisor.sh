#!/bin/bash

set -u
set -e

PROJECT=$1
PY_MIRROR=$2

apt-get install -q -y python-pip
pip install -i $PY_MIRROR -U supervisor
cp /vagrant/config/supervisor-${PROJECT}.conf /etc/supervisord.conf
if [ -e /vagrant/config/env ]
then
    SUPERVISOR_ENV=$(sed '/\(#\)\|\(^\s*$\)/d' /vagrant/config/env|awk -F'=' '{printf "    %s=\"%s\",\n", $1,$2}')
    cat <<EOF >> /etc/supervisord.conf
environment=$SUPERVISOR_ENV
EOF
fi
cp /vagrant/config/supervisor.init /etc/init.d/supervisor
chmod +x /etc/init.d/supervisor
update-rc.d supervisor defaults 21
service supervisor start
