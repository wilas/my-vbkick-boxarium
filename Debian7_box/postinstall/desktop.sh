#!/bin/bash
set -e -E -u -o pipefail; shopt -s failglob;

# Add the debian-mozilla repo
if [[ ! -f "/etc/apt/sources.list.d/mozilla-iceweasel.list" ]]; then
    echo 'deb http://mozilla.debian.net/ wheezy-backports iceweasel-release' > /etc/apt/sources.list.d/mozilla-iceweasel.list
    apt-get -y update
fi
# Install the new iceweasel from mozilla repo
apt-get -y install -t wheezy-backports iceweasel

# Add backports (choose your mirror from http://backports.debian.org/Mirrors/)
#if [[ ! -f "/etc/apt/sources.list.d/wheezy-backports.list" ]]; then
#    echo 'deb http://ftp.debian.org/debian wheezy-backports main' > /etc/apt/sources.list.d/wheezy-backports.list
#    apt-get -y update
#fi

# Flash
## update repo with contrib and non-free (may be done in preseed.cfg): 'deb http://ftp.uk.debian.org/debian wheezy main contrib non-free'
#apt-get -y install flashplugin-nonfree

# Java
# apt-cache search openjdk
# apt-get -y install openjdk-7-jdk or apt-get -y install openjdk-7-jre
# apt-get -y install icedtea-7-plugin
