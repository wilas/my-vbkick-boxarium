#!/bin/bash
set -e -E -u -o pipefail; shopt -s failglob;

# Polish keyboard
sed -i 's:^XKBMODEL=.*:XKBMODEL="pc105":' /etc/default/keyboard
sed -i 's:^XKBLAYOUT=.*:XKBLAYOUT="pl":' /etc/default/keyboard
dpkg-reconfigure -fnoninteractive keyboard-configuration

sed -i 's:^CODESET=.*:CODESET="Lat2":' /etc/default/console-setup
dpkg-reconfigure -fnoninteractive console-setup

# Check current setings:
# debconf-show keyboard-configuration
# debconf-show console-setup
