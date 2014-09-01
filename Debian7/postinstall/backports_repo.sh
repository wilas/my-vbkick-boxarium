#!/bin/bash
set -e -E -u -o pipefail; shopt -s failglob;

# Debian backports: http://backports.debian.org/Instructions/
if [[ ! -f "/etc/apt/sources.list.d/wheezy-backports.list" ]]; then
    echo 'deb http://ftp.debian.org/debian wheezy-backports main' > /etc/apt/sources.list.d/wheezy-backports.list
    apt-get -y update
fi
