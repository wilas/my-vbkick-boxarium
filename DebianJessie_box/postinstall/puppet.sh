#!/bin/bash
set -e -E -u -o pipefail; shopt -s failglob;

if [[ ! -f "/etc/apt/sources.list.d/puppetlabs.list" ]]; then
    wget -O /tmp/puppetlabs-release-sid.deb http://apt.puppetlabs.com/puppetlabs-release-sid.deb
    dpkg -i /tmp/puppetlabs-release-sid.deb
    rm -f /tmp/puppetlabs-release-sid.deb
    apt-get -y update
fi
# https://tickets.puppetlabs.com/browse/CPR-13 hiera (v1.3.2) conflicts with the system package - ruby-hiera
apt-get install -y puppet facter #hiera
