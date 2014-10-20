#!/bin/bash

set -u
set -e

NOTSET="notset"
RUBY_URL=$1
RUBY_MIRROR=${2:-$NOTSET}
RUBY_TMP=/tmp/$(echo $RUBY_URL|md5sum|cut -d' ' -f1)

apt-get -y purge ruby rubygems
apt-get install -y -q \
    autoconf \
    bison \
    build-essential \
    curl \
    libssl-dev \
    libyaml-dev \
    libreadline6-dev \
    zlib1g-dev \
    libncurses5-dev

rm -rf $RUBY_TMP
mkdir -p $RUBY_TMP
pushd $RUBY_TMP
    echo "downloading $RUBY_URL"
    curl -sO $RUBY_URL
    tar xf $(basename $RUBY_URL)
    pushd $(ls -d */)
        ./configure --disable-install-rdoc
        make
        make install
    popd
popd
rm -rf $RUBY_TMP

if [ $RUBY_MIRROR != $NOTSET ]
then
    gem sources --remove https://rubygems.org/
    gem sources -a $RUBY_MIRROR
fi

echo 'gem: --no-ri --no-rdoc' >> ~/.gemrc
gem install bundler --no-ri --no-rdoc
