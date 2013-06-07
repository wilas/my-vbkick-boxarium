# Installing the virtualbox guest additions
# need kernel headers to compile module and virtualbox tools
apt-get -y install linux-headers-$(uname -r) dkms
# apt-get -y install libdbus-1-3
wget -O /tmp/VBoxGuestAdditions_$VBOX_VERSION.iso http://download.virtualbox.org/virtualbox/$VBOX_VERSION/VBoxGuestAdditions_$VBOX_VERSION.iso
mount -o loop /tmp/VBoxGuestAdditions_$VBOX_VERSION.iso /mnt
sh /mnt/VBoxLinuxAdditions.run
umount /mnt
rm -f /tmp/VBoxGuestAdditions_$VBOX_VERSION.iso
