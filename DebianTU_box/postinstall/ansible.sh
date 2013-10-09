#!/bin/bash
set -eEu
set -o pipefail

# Install ansible
version="1.3.2"
if ! dpkg -l ansible | grep -qw "${version}"; then
    apt-get install -y cdbs debhelper dpkg-dev git reprepro python-support python-apt python-paramiko python-yaml python-jinja2 sshpass
    cd /tmp && git clone git://github.com/ansible/ansible.git
    cd /tmp/ansible/ && git checkout "release${version}" && make deb
    dpkg -i /tmp/ansible*.deb
    rm -f /tmp/ansible*.deb
    rm -rf /tmp/ansible
fi
