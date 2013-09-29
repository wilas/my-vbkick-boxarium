# Install docker from sources (github): https://github.com/dotcloud/docker.git

# some extra package are needed, installed using preseeding (look into kickstart/ directory)
apt-get -y install curl wget git

# Install lxc, aufs and other dependencies (debootstrap libcap2-bin libpam-cap)
if [ ! -f "/etc/default/lxc" ]; then
cat > /etc/default/lxc << EOF
# /etc/default/lxc

LXC_AUTO="true"
LXC_DIRECTORY="/var/lib/lxc"
EOF
fi
apt-get -y install lxc aufs-tools bsdtar

# Install go1.1 (Wheezy has 1.0.2, but 1.1 is required for docker)
## remove go1.0.2 if exist
if dpkg -l golang 1>/dev/null 2>&1; then
    apt-get -y autoremove golang
fi
if [ ! -f "/usr/local/bin/go" ]; then
    wget -O /tmp/go.tar.gz https://go.googlecode.com/files/go1.1.1.linux-amd64.tar.gz
    tar -C /usr/local -xzf /tmp/go.tar.gz
    ln -fs /usr/local/go/bin/go /usr/local/bin/go
fi

# Build and install the lxc-docker*.deb package from the github
if [ ! -f "/usr/bin/lxc-docker" ]; then
    ## get the src (other src: git://github.com/dotcloud/docker-debian.git)
    cd /tmp && git clone git://github.com/dotcloud/docker.git
    pkg_location="/tmp/docker/packaging/debian"
    ## install deps. needed to build package
    apt-get -y install mercurial build-essential debhelper autotools-dev #devscripts
    ## go was installed manually, remove golang from deps.
    sed -i 's:^\(Build-Depends.*\), golang:\1:' "${pkg_location}/control"
    ## run make, it exit with 2, but this is ok, we don't sign the package (only for local use)
    cd $pkg_location && make debian
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
    sh -c "echo 'net.ipv4.ip_forward = 1' >> /etc/sysctl.conf"
fi

# Mount cgroup on the system
if ! grep -q 'cgroup' /etc/fstab; then
    sh -c "echo 'cgroup       /sys/fs/cgroup        cgroup        defaults    0    0' >> /etc/fstab"
    mount /sys/fs/cgroup
fi

# Update grub to enable memory and swap accounting: http://docs.docker.io/en/latest/installation/kernel/
sed -i 's:^#GRUB_CMDLINE_LINUX=:GRUB_CMDLINE_LINUX=:' /etc/default/grub
sed -i 's:^GRUB_CMDLINE_LINUX=.*:GRUB_CMDLINE_LINUX="cgroup_enable=memory swapaccount=1":' /etc/default/grub
update-grub

# Reboot
printf "reboot ...\n"
reboot

# Quick test
# sudo lxc-checkconfig
# sudo service lxc-docker status
# sudo lxc-docker run -i -t ubuntu /bin/bash
# sudo lxc-docker run -dns 8.8.8.8 centos ping google.com
