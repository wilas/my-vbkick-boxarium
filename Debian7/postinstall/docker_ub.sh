#!/bin/bash
set -e -E -u -o pipefail; shopt -s failglob;

# Install lxc-docker using ubuntu repo from docker.io

# Check arch
arch=$(uname -m)
if [[ "${arch}" != 'x86_64' ]]; then
    echo "${arch} arch is not supported."
    exit 0
fi

# Extra packages needed
apt-get -y install curl apt-transport-https

# Add the Docker repository
if [[ ! -f "/etc/apt/sources.list.d/docker.list" ]]; then
    #curl -k https://get.docker.io/gpg | apt-key add -
    apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 36A1D7869245C8950F966E92D8576A8BA88D21E9
    echo 'deb https://get.docker.io/ubuntu docker main' > /etc/apt/sources.list.d/docker.list
    apt-get -y update
fi

# Install lxc-docker with dependencies
env DEBIAN_FRONTEND=noninteractive apt-get -y install lxc-docker

# Enable IPv4 forwarding (by default disabled on Debian)
sysctl -w net.ipv4.ip_forward=1
if grep -q '^net.ipv4.ip_forward' /etc/sysctl.conf; then
    sed -i 's:^net.ipv4.ip_forward.*:net.ipv4.ip_forward = 1:' /etc/sysctl.conf
elif grep -q '^#net.ipv4.ip_forward' /etc/sysctl.conf; then
    sed -i 's:^#net.ipv4.ip_forward.*:net.ipv4.ip_forward = 1:' /etc/sysctl.conf
else
    echo 'net.ipv4.ip_forward = 1' >> /etc/sysctl.conf
fi

# Update grub to enable memory and swap accounting (reboot required): http://docs.docker.io/en/latest/installation/kernel/
sed -i 's:^#GRUB_CMDLINE_LINUX=:GRUB_CMDLINE_LINUX=:' /etc/default/grub
sed -i 's:^GRUB_CMDLINE_LINUX=.*:GRUB_CMDLINE_LINUX="cgroup_enable=memory swapaccount=1":' /etc/default/grub
update-grub

# NB1: cgroups are mounted on the system via docker init script

# Quick test
# sudo lxc-checkconfig
# sudo service docker status
# sudo docker info
# sudo docker run -i -t ubuntu /bin/bash
# sudo docker run -dns 8.8.8.8 centos ping google.com
