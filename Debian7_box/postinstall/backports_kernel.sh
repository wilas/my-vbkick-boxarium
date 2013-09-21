# Debian backports: http://backports.debian.org/Instructions/
# Add backports (choose your mirror from http://backports.debian.org/Mirrors/)
if [ ! -f "/etc/apt/sources.list.d/wheezy-backports.list" ]; then
    sh -c "echo 'deb http://ftp.debian.org/debian wheezy-backports main' >> /etc/apt/sources.list.d/wheezy-backports.list"
fi

# Update sources
apt-get update

# Install the new linux kernel and headers from backports
# Available 3.10 kernels:
# linux-image-3.10-0.bpo.2-amd64 - Linux 3.10 for 64-bit PCs
# PREEMPT_RT (rt patch - Linux into a real time system - https://rt.wiki.kernel.org/index.php/Main_Page)
# linux-image-3.10-0.bpo.2-rt-amd64 - Linux 3.10 for 64-bit PCs, PREEMPT_RT 
kversion="3.10-0.bpo.2"
apt-get -y install -t wheezy-backports linux-image-$kversion-amd64 linux-headers-$kversion-amd64 
#linux-headers-$kversion-all-amd64 

# Note: AUFS is included in the kernels built by the Debian and Ubuntu distributions, is not part of the standard kernel. 
# More: http://docs.docker.io/en/latest/installation/kernel/#kernel

# Reboot
printf "reboot ...\n"
reboot