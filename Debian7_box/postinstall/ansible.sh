# Install ansible - unstable
apt-get install -y cdbs debhelper dpkg-dev git-core reprepro python-support python-apt python-paramiko python-yaml python-jinja2
cd /tmp && git clone git://github.com/ansible/ansible.git
cd /tmp/ansible/ && make deb
dpkg -i /tmp/ansible*.deb
rm -rf /tmp/ansible
rm -f /tmp/ansible*.deb
