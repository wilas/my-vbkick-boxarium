#!/bin/bash
set -eEu

wget http://apt.puppetlabs.com/puppetlabs-release-wheezy.deb -O /tmp/puppetlabs-release-wheezy.deb
dpkg -i /tmp/puppetlabs-release-wheezy.deb
rm -f /tmp/puppetlabs-release-wheezy.deb
apt-get -y update

apt-get install -y hiera puppet facter
