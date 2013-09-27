wget http://apt.puppetlabs.com/puppetlabs-release-sid.deb -O /tmp/puppetlabs-release-sid.deb
dpkg -i /tmp/puppetlabs-release-sid.deb
rm -f /tmp/puppetlabs-release-sid.deb
apt-get -y update

apt-get install -y hiera puppet facter
