# Base install

# Resync the package index files
apt-get -y update
apt-get -y dist-upgrade

# Tweak sshd to prevent DNS resolution (speed up logins)
echo 'UseDNS no' >> /etc/ssh/sshd_config

# If X needed
#apt-get install xserver-xorg xserver-xorg-core
