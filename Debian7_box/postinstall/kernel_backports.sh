#!/bin/bash
set -e -E -u -o pipefail; shopt -s failglob;

# Debian backports: http://backports.debian.org/Instructions/
if [[ ! -f "/etc/apt/sources.list.d/wheezy-backports.list" ]]; then
    echo 'deb http://ftp.debian.org/debian wheezy-backports main' > /etc/apt/sources.list.d/wheezy-backports.list
    apt-get -y update
fi

# Install the new linux kernel and headers from backports
apt-get -y install -t wheezy-backports linux-image-amd64 linux-headers-amd64

# Note1: AUFS is included in the kernels built by the Debian and Ubuntu distributions, 
# is not part of the standard kernel, more: http://docs.docker.io/en/latest/installation/kernel/#kernel
