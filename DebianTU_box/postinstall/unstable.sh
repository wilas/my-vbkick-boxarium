# Useful to upgrade from Jessie (testing) to Sid (unstable)

# udpdate packages repo to unstable (Sid)
if ! grep -q 'unstable' /etc/apt/sources.list; then
        sed -i 's~^deb\(.*\)~#deb\1~' /etc/apt/sources.list
        echo "" >> /etc/apt/sources.list
        echo "deb http://ftp.uk.debian.org/debian unstable main" >> /etc/apt/sources.list
        echo "deb-src http://ftp.uk.debian.org/debian unstable main" >> /etc/apt/sources.list
        #echo "deb http://ftp.uk.debian.org/debian unstable main contrib non-free" >> /etc/apt/sources.list
        #echo "deb-src http://ftp.uk.debian.org/debian unstable main contrib non-free" >> /etc/apt/sources.list
        apt-get -y update
fi

# upgrade and clean distro
apt-get -y dist-upgrade
apt-get -y autoremove

# Reboot (needed if new kernel was installed)
printf "reboot ...\n"
reboot
