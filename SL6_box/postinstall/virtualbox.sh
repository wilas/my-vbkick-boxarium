# Installing the virtualbox guest additions
# VBoxGuestAdditions iso is attached (by vbkick) to IDE Controller port 1 device 0
mount /dev/sr1 /mnt
sh /mnt/VBoxLinuxAdditions.run
umount /mnt

# Old wget method
#wget -O /tmp/VBoxGuestAdditions_$VBOX_VERSION.iso http://10.0.2.2:7122/iso/VBoxGuestAdditions_$VBOX_VERSION.iso
#wget -O /tmp/VBoxGuestAdditions_$VBOX_VERSION.iso http://download.virtualbox.org/virtualbox/$VBOX_VERSION/VBoxGuestAdditions_$VBOX_VERSION.iso
#mount -o loop /tmp/VBoxGuestAdditions_$VBOX_VERSION.iso /mnt
#sh /mnt/VBoxLinuxAdditions.run
#umount /mnt
#rm -f /tmp/VBoxGuestAdditions_$VBOX_VERSION.iso
