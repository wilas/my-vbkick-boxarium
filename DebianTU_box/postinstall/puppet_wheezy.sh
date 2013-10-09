#!/bin/bash
set -eEu
set -o pipefail

if [[ ! -f "/etc/apt/sources.list.d/puppetlabs.list" ]]; then
    wget -O /tmp/puppetlabs-release-wheezy.deb http://apt.puppetlabs.com/puppetlabs-release-wheezy.deb
    dpkg -i /tmp/puppetlabs-release-wheezy.deb
    rm -f /tmp/puppetlabs-release-wheezy.deb
    apt-get -y update
fi
apt-get install -y hiera puppet facter
