# Install lxc-docker using repo for ubuntu from docker.io

# some extra package are needed, installed using preseeding (look into kickstart/ directory)
apt-get -y install curl wget

# https in sources
apt-get -y install apt-transport-https

# Add the Docker repository
if [ ! -f "/etc/apt/sources.list.d/docker.list" ]; then
    sh -c "curl https://get.docker.io/gpg | apt-key add -"
    sh -c "echo 'deb https://get.docker.io/ubuntu docker main' > /etc/apt/sources.list.d/docker.list"
fi

# Update sources
apt-get update

# Install lxc-docker with dependencies
if [ ! -f "/etc/default/lxc" ]; then
cat > /etc/default/lxc << EOF
# /etc/default/lxc

LXC_AUTO="true"
LXC_DIRECTORY="/var/lib/lxc"
EOF
fi
apt-get -y install lxc-docker --force-yes
# Fix installation - Ubuntu package use upstart to start/stop the docker daemon, this doesn't work on Debian
version=$(apt-cache search lxc-docker | sort -r -k1,1 | head -1 | cut -f1 -d' ' | tr -d 'lxc-docker-')
sed -i 's:/sbin/start:#/sbin/start:' /var/lib/dpkg/info/lxc-docker-$version.postinst
sed -i 's:/sbin/stop:#/sbin/stop:' /var/lib/dpkg/info/lxc-docker-$version.prerm
apt-get -f install

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

# Creates init.d srcipt and enable service
if [ ! -f "/etc/init.d/lxc-docker" ]; then
    ## other src: https://raw.github.com/dotcloud/docker-debian/upstream/packaging/debian/lxc-docker.init
    wget -O /tmp/lxc-docker.init --no-check-certificate https://raw.github.com/dotcloud/docker/master/packaging/debian/lxc-docker.init
    docker_path=$(which docker)
    sed -i "s:^DOCKER=.*:DOCKER=$docker_path:" /tmp/lxc-docker.init
    install -g 0 -o 0 -m 0755 -p /tmp/lxc-docker.init /etc/init.d/lxc-docker
    update-rc.d lxc-docker defaults
    ## to remove run: sudo invoke-rc.d lxc-docker stop && sudo update-rc.d -f lxc-docker remove
fi

# Reboot
printf "reboot ...\n"
reboot

# Quick test
# sudo lxc-checkconfig
# sudo service lxc-docker status
# sudo docker run -i -t ubuntu /bin/bash
