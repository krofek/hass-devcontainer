#!/usr/bin/env bash

set -x

# shellcheck disable=SC1091
source /tmp/build/docker.sh

function install_deps()
{
    apt-get update
    apt-get install -y --no-install-recommends \
        dbus \
        network-manager \
        libpulse0 \
        xz-utils \
        ca-certificates \
        curl \
        gnupg \
        systemd-journal-remote
}

# Install cosign
function install_cosign() {
    curl -fLs \
        "https://github.com/sigstore/cosign/releases/download/v${COSIGN_VERSION}/cosign-linux-${DOCKER_ARCH}" \
        --output ./cosign

    chmod +x ./cosign
    mv -f ./cosign /usr/local/bin/cosign
    rm -f ./cosign
}

# Install os-agent
function install_os_agent() {
    curl -Lso ./os-agent.deb \
        "https://github.com/home-assistant/os-agent/releases/download/${OS_AGENT_VERSION}/os-agent_${OS_AGENT_VERSION}_linux_${ARCH}.deb"

    dpkg -i ./os-agent.deb
    rm ./os-agent.deb
}

# Install shellcheck
function install_shellcheck() {
    curl -fLs \
        "https://github.com/koalaman/shellcheck/releases/download/stable/shellcheck-stable.linux.${ARCH}.tar.xz" \
        | tar -xJ

    mv -f "./shellcheck-stable/shellcheck" "/usr/bin/shellcheck"
    rm -rf "./shellcheck-stable"
}

# Install Deps
echo "Installing Deps"
install_deps

# Prepare supervisor
echo "Prepare supervisor"
prepare_supervisor

# Install packages
echo "Install packages"
install_cosign
install_os_agent
install_shellcheck
install_docker
