# Installing the virtualbox guest additions
# need kernel headers to compile module and virtualbox tools
apt-get -y install linux-headers-$(uname -r) dkms
# apt-get -y install libdbus-1-3
# VBoxGuestAdditions iso is attached (by vbkick) to IDE Controller port 1 device 0
mount /dev/sr1 /mnt
sh /mnt/VBoxLinuxAdditions.run
umount /mnt
