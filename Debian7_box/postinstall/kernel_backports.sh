#!/bin/bash
set -eEu

# Debian backports: http://backports.debian.org/Instructions/
# Add backports (choose your mirror from http://backports.debian.org/Mirrors/)
if [[ ! -f "/etc/apt/sources.list.d/wheezy-backports.list" ]]; then
    sh -c "echo 'deb http://ftp.debian.org/debian wheezy-backports main' >> /etc/apt/sources.list.d/wheezy-backports.list"
    apt-get -y update
fi

# Install the new linux kernel and headers from backports
apt-get -y install -t wheezy-backports linux-image-amd64 linux-headers-amd64
#kversion="3.10-0.bpo.2" && apt-get -y install -t wheezy-backports linux-image-$kversion-amd64 linux-headers-$kversion-amd64 

# Note: AUFS is included in the kernels built by the Debian and Ubuntu distributions, is not part of the standard kernel. 
# More: http://docs.docker.io/en/latest/installation/kernel/#kernel
