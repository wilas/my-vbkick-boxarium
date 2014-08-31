#!/bin/bash
set -e -E -u -o pipefail; shopt -s failglob;

# Install ansible
version="1.7.1"
if ! dpkg -l ansible | grep -qw "${version}"; then
    apt-get install -y cdbs debhelper dpkg-dev pdebuild-cross git reprepro python-apt python-support fakeroot asciidoc python-setuptools
    apt-get install -y python-paramiko python-yaml python-jinja2 python-httplib2 sshpass #python-keyczar
    cd /tmp && git clone git://github.com/ansible/ansible.git
    cd /tmp/ansible/ && git checkout "release${version}" && make deb
    dpkg -i /tmp/ansible/deb-build/unstable/ansible*deb
    rm -rf /tmp/ansible
fi
