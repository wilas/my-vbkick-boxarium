#!/bin/bash
set -eEu
set -o pipefail

# Install docker from sources (github): https://github.com/dotcloud/docker.git

# some extra package are needed, installed using preseeding (look into kickstart/ directory)
apt-get -y install curl wget git

# Install lxc, aufs and other dependencies (debootstrap libcap2-bin libpam-cap)
if [[ ! -f "/etc/default/lxc" ]]; then
cat > /etc/default/lxc << EOF
# /etc/default/lxc

LXC_AUTO="true"
LXC_DIRECTORY="/var/lib/lxc"
EOF
fi
apt-get -y install lxc aufs-tools bsdtar golang

# Build and install the lxc-docker*.deb package from the github
if ! dpkg -l lxc-docker >/dev/null 2>&1; then
    ## get the src (other src: git://github.com/dotcloud/docker-debian.git)
    cd /tmp && git clone git://github.com/dotcloud/docker.git
    pkg_location="/tmp/docker/packaging/debian"
    ## install deps. needed to build package
    apt-get -y install mercurial build-essential debhelper autotools-dev #devscripts
    ## run make, it exit with 2, but this is ok, we don't sign the package (only for local use)
    cd $pkg_location && make debian || true
    ## install already created package
    dpkg -i $pkg_location/lxc-docker_*-1_amd64.deb
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

# Quick test
# sudo lxc-checkconfig
# sudo service lxc-docker status
# sudo lxc-docker run -i -t ubuntu /bin/bash
# sudo lxc-docker run -dns 8.8.8.8 centos ping google.com
