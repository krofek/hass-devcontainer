#!/usr/bin/env bash

set -x

# Load common functions
# shellcheck disable=SC1091
source install_common.sh

# Prepare supervisor
echo "Prepare supervisor"
prepare_supervisor

# Install packages
echo "Install deps"
install_cosign
install_os_agent
install_shellcheck

