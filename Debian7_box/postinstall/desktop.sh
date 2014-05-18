#!/bin/bash
set -e -E -u -o pipefail; shopt -s failglob;

# The new iceweasel
## Add the debian-mozilla repo (http://mozilla.debian.net/)
if [[ ! -f "/etc/apt/sources.list.d/mozilla-iceweasel.list" ]]; then
    echo 'deb http://mozilla.debian.net/ wheezy-backports iceweasel-release' > /etc/apt/sources.list.d/mozilla-iceweasel.list
    wget -O /tmp/mozilla-keyring.deb --no-check-certificate http://mozilla.debian.net/pkg-mozilla-archive-keyring_1.1_all.deb
    dpkg -i /tmp/mozilla-keyring.deb
    rm -f /tmp/mozilla-keyring.deb
    apt-get -y update
fi
## Install the new iceweasel from mozilla repo
apt-get -y install -t wheezy-backports iceweasel

# Flash
## update repo with contrib and non-free (done in preseed.cfg): 'deb http://ftp.uk.debian.org/debian wheezy main contrib non-free'
#apt-get -y install flashplugin-nonfree

# Java
# apt-cache search openjdk
# apt-get -y install openjdk-7-jdk or apt-get -y install openjdk-7-jre
# apt-get -y install icedtea-7-plugin
