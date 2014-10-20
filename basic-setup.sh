#!/bin/bash

set -u
set -e

TIMEZONE=$1
UBUNTU_MIRROR=$2

echo "update timezone"
echo "$TIMEZONE" > /etc/timezone
dpkg-reconfigure -f noninteractive tzdata

echo "use ali's mirror and update sources"
cat <<EOF > /etc/apt/sources.list
deb $UBUNTU_MIRROR trusty main restricted universe multiverse
deb $UBUNTU_MIRROR trusty-security main restricted universe multiverse
deb $UBUNTU_MIRROR trusty-updates main restricted universe multiverse
deb $UBUNTU_MIRROR trusty-proposed main restricted universe multiverse
deb $UBUNTU_MIRROR trusty-backports main restricted universe multiverse
EOF

apt-get update -y
apt-get upgrade -y

echo "install basic packages for dirty work"
apt-get install -q -y tmux vim rxvt-unicode-256color htop
