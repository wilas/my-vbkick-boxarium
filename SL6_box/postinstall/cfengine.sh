#!/bin/bash
set -e -E -u -o pipefail; shopt -s failglob;

if [[ ! -f "/etc/yum.repos.d/cfengine-community.repo" ]]; then
    wget -O /tmp/gpg_cfengine.key http://cfengine.com/pub/gpg.key
    rpm --import /tmp/gpg_cfengine.key
    rm -f /tmp/gpg_cfengine.key
    printf "[cfengine-repository]\nname=CFEngine\nbaseurl=http://cfengine.com/pub/yum/\nenabled=1\ngpgcheck=1\n" > /etc/yum.repos.d/cfengine-community.repo
fi
yum -y --enablerepo=cfengine-repository install cfengine-community
