#!/usr/bin/env bash

set -e

# Load common functions
source ./common.sh

# Install packages
echo "Install common packages"
install_cosign
install_os_agent
install_shellcheck

# Prepare supervisor
echo "Prepare supervisor"
prepare_supervisor
