#!/bin/bash
set -e -E -u -o pipefail; shopt -s failglob;

printf "[WARNING] BETA script - lxc not yet in epel.\n"

# Install docker-io
yum -y --enablerepo=epel-testing install docker-io

if ! service docker status > /dev/null; then
    service docker restart
    service docker status || true
    # Usually: 'docker dead but subsys locked'
    # Better is just reboot host.
    # Note: docker service is by default enabled to start automatically during the system bootup
fi

# Inspection:
# chkconfig --list docker
# chkconfig --list cgconfig
# sysctl net.ipv4.ip_forward
# ls /cgroup/
# less /etc/init.d/docker
# less /etc/cgconfig.conf
# less /etc/sysconfig/selinux
# less /etc/fstab
# less /etc/grub.conf

# Quick test
# sudo lxc-checkconfig
# sudo service docker status
# sudo docker info
# sudo docker run -i -t ubuntu /bin/bash
# sudo docker run -dns 8.8.8.8 centos ping google.com

# Debug pulling: curl -v https://registry-1.docker.io/_ping
