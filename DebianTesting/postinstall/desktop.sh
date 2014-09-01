#!/bin/bash
set -e -E -u -o pipefail; shopt -s failglob;

# Add the cdn-unstable repo (more: http://mozilla.debian.net/)(using this you mix distribution, read: https://wiki.debian.org/AptPreferences)
#if [[ ! -f "/etc/apt/sources.list.d/cdn-unstable.list" ]]; then
#    echo 'deb http://cdn.debian.net/debian unstable main' > /etc/apt/sources.list.d/cdn-unstable.list
#    apt-get -y update
#fi
# Install the new iceweasel from unstable repo
#apt-get -y install -t unstable iceweasel

# Add backports (done in preseed.cfg)
#if [[ ! -f "/etc/apt/sources.list.d/jessie-backports.list" ]]; then
#    echo 'deb http://ftp.debian.org/debian jessie-backports main' > /etc/apt/sources.list.d/jessie-backports.list
#    apt-get -y update
#fi

# Flash
## update repo with contrib and non-free (done in preseed.cfg): 'deb http://ftp.uk.debian.org/debian jessie main contrib non-free'
#apt-get -y install flashplugin-nonfree
#apt-get -y install pepperflashplugin-nonfree

# Java
# apt-cache search openjdk
# apt-get -y install openjdk-7-jdk or apt-get -y install openjdk-7-jre
# apt-get -y install icedtea-7-plugin
