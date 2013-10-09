#!/bin/bash
set -eEu
set -o pipefail

# Installing chef
curl -Lk https://www.opscode.com/chef/install.sh | bash
