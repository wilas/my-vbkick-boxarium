#!/bin/bash
set -e -E -u -o pipefail; shopt -s failglob;

# Install docker using binaries from docker.io: http://docs.docker.io/en/latest/installation/binaries/

# some extra package are needed, installed using preseeding (look into kickstart/ directory)
apt-get -y install curl wget

# Install lxc, aufs and other dependencies (debootstrap libcap2-bin libpam-cap)
env DEBIAN_FRONTEND=noninteractive apt-get -y install lxc aufs-tools bsdtar

# Get the docker binary
if [[ ! -f "/usr/local/bin/lxc-docker" ]]; then
    ## other url: http://get.docker.io/builds/Linux/x86_64/docker-latest.tgz
    wget -O /tmp/docker --no-check-certificate https://get.docker.io/builds/Linux/x86_64/docker-latest
    install -g 0 -o 0 -m 0755 -p /tmp/docker /usr/local/bin/lxc-docker
fi

# Enable IPv4 forwarding (by default disabled on Debian)
sysctl -w net.ipv4.ip_forward=1
## permanent setting
if grep -q '^net.ipv4.ip_forward' /etc/sysctl.conf; then
    sed -i 's:^net.ipv4.ip_forward.*:net.ipv4.ip_forward = 1:' /etc/sysctl.conf
elif grep -q '^#net.ipv4.ip_forward' /etc/sysctl.conf; then
    sed -i 's:^#net.ipv4.ip_forward.*:net.ipv4.ip_forward = 1:' /etc/sysctl.conf
else
    echo 'net.ipv4.ip_forward = 1' >> /etc/sysctl.conf
fi

# Mount cgroup on the system
if ! grep -q 'cgroup' /etc/fstab; then
    echo 'cgroup       /sys/fs/cgroup        cgroup        defaults    0    0' >> /etc/fstab
fi
if ! mount | grep -q 'cgroup'; then
    mount /sys/fs/cgroup
fi

# Update grub to enable memory and swap accounting: http://docs.docker.io/en/latest/installation/kernel/
sed -i 's:^#GRUB_CMDLINE_LINUX=:GRUB_CMDLINE_LINUX=:' /etc/default/grub
sed -i 's:^GRUB_CMDLINE_LINUX=.*:GRUB_CMDLINE_LINUX="cgroup_enable=memory swapaccount=1":' /etc/default/grub
update-grub

# Creates init.d srcipt and enable service
if [[ ! -f "/etc/init.d/lxc-docker" ]]; then
    ## Read: https://github.com/dotcloud/docker/pull/2169
    #wget -O /tmp/lxc-docker.init --no-check-certificate https://raw.github.com/dotcloud/docker/master/hack/packaging/debian/lxc-docker.init
    wget -O /tmp/lxc-docker.init --no-check-certificate https://raw.github.com/dotcloud/docker-debian/master/packaging/debian/lxc-docker.init
    docker_path="/usr/local/bin/lxc-docker"
    sed -i "s:^DOCKER=.*:DOCKER=$docker_path:" /tmp/lxc-docker.init
    install -g 0 -o 0 -m 0755 -p /tmp/lxc-docker.init /etc/init.d/lxc-docker
    update-rc.d lxc-docker defaults
    ## to remove run: sudo invoke-rc.d lxc-docker stop && sudo update-rc.d -f lxc-docker remove
fi

# Quick test
# sudo lxc-checkconfig
# sudo service lxc-docker status
# sudo lxc-docker run -i -t ubuntu /bin/bash
# sudo lxc-docker run -dns 8.8.8.8 centos ping google.com
