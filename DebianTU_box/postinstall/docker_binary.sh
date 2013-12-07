#!/bin/bash
set -e -E -u -o pipefail; shopt -s failglob;

# Install docker using binaries from docker.io: http://docs.docker.io/en/latest/installation/binaries/
docker_path="/usr/local/bin/lxc-docker"

# Extra packages needed
apt-get -y install curl wget

# Install lxc, aufs and other dependencies: https://github.com/dotcloud/docker/blob/master/hack/PACKAGERS.md
env DEBIAN_FRONTEND=noninteractive apt-get -y install lxc aufs-tools
apt-get -y install tar git iproute iptables xz-utils bridge-utils

# Get the docker binary
if [[ ! -f "${docker_path}" ]]; then
    # wget -O /tmp/docker-latest.tgz --no-check-certificate http://get.docker.io/builds/Linux/x86_64/docker-latest.tgz
    # tar -xfz docker-latest.tgz -C /tmp
    # install -g 0 -o 0 -m 0755 -p /tmp/usr/local/bin/docker "${docker_path}"
    wget -O /tmp/docker --no-check-certificate https://get.docker.io/builds/Linux/x86_64/docker-latest
    install -g 0 -o 0 -m 0755 -p /tmp/docker "${docker_path}"
fi

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

# Creates init.d srcipt and enable service
if [[ ! -f "/etc/init.d/lxc-docker" ]]; then
    wget -O /tmp/lxc-docker.init --no-check-certificate https://raw.github.com/dotcloud/docker-debian/master/packaging/debian/lxc-docker.init
    sed -i "s:^DOCKER=.*:DOCKER=${docker_path}:" /tmp/lxc-docker.init
    install -g 0 -o 0 -m 0755 -p /tmp/lxc-docker.init /etc/init.d/lxc-docker
    service lxc-docker start
    insserv lxc-docker
    # alternative: update-rc.d lxc-docker defaults; update-rc.d -f lxc-docker remove
fi

# Note1: cgroups are mounted on the system via docker init script

# Quick test
# sudo lxc-checkconfig
# sudo service lxc-docker status
# sudo lxc-docker info
# sudo lxc-docker run -i -t ubuntu /bin/bash
# sudo lxc-docker run -dns 8.8.8.8 centos ping google.com
