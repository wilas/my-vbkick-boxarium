#!/bin/bash
set -eEu
set -o pipefail

# Zero out the free space to save space in the final image:
dd if=/dev/zero of=/EMPTY bs=1M || true
rm -f /EMPTY
