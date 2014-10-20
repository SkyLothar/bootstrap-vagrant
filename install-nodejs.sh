#!/bin/bash

set -u
set -e

NODEJS_URL=$1
NODEJS_TMP=/tmp/$(echo $NODEJS_URL|md5sum|cut -d' ' -f1)

apt-get -q -y purge \
    nodejs \
    npm
apt-get -q -y install \
    build-essential \
    curl \
    openssl \
    libssl-dev \
    pkg-config

rm -rf $NODEJS_TMP
mkdir -p $NODEJS_TMP
pushd $NODEJS_TMP
    echo "downloading ${NODEJS_URL}"
    curl -sO $NODEJS_URL
    tar xf $(basename $NODEJS_URL)
    pushd $(ls -d */)
        ./configure
        make
        make install
    popd
popd
rm -rf ${NODEJS_TMP}
