#!/bin/bash

set -u
set -e

NOTSET="notset"
PIP_URL="https://bootstrap.pypa.io/get-pip.py"

PY_URL=$1
PY_MIRROR=${2:-$NOTSET}
PY_TMP=/tmp/$(echo $PY_URL|md5sum|cut -d' ' -f1)

apt-get -y purge python python-pip
apt-get install -y -q \
    make \
    build-essential \
    libssl-dev \
    zlib1g-dev \
    libbz2-dev \
    libreadline-dev \
    libsqlite3-dev \
    wget \
    curl \
    llvm

rm -rf $PY_TMP
mkdir -p $PY_TMP
pushd $PY_TMP
    echo "downloading $PY_URL"
    curl -sO $PY_URL
    tar xf $(basename $PY_URL)
    pushd $(ls -d */)
        ./configure
        make
        make install
    popd
    curl -s $PIP_URL|python
    if [ $PY_MIRROR != $NOTSET ]
    then
        PYPI_INDEX="-i $PY_MIRROR"
    else
        PYPI_INDEX=""
    fi
    pip install -U $PYPI_INDEX virtualenv setuptools
popd
rm -rf $PY_TMP
