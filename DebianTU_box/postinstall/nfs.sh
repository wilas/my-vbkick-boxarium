#!/bin/bash
set -eEu
set -o pipefail

# Install NFS for Vagrant
apt-get -y install nfs-common
