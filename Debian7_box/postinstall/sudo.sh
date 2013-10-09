#!/bin/bash
set -eEu
set -o pipefail

# Allow sudo commands without a tty
sed -i -re "s/(^Defaults[ ]+requiretty)/#\1/" /etc/sudoers
