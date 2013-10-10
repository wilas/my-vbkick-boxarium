#!/bin/bash
set -eEu
set -o pipefail

# Installing chef
gem install --no-ri --no-rdoc chef
#curl -Lk https://www.opscode.com/chef/install.sh | bash
