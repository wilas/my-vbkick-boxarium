#!/bin/bash
set -e -E -u -o pipefail; shopt -s failglob;

# Installing chef
#gem install --no-ri --no-rdoc chef
curl -Lk https://www.opscode.com/chef/install.sh | bash
