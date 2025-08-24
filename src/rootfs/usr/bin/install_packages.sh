#!/usr/bin/env bash

set -x

# Load common functions
# shellcheck disable=SC1091
source install_common.sh

# Install packages
echo "Install common packages"
install_cosign
install_os_agent
install_shellcheck

# Prepare supervisor
echo "Prepare supervisor"
prepare_supervisor
