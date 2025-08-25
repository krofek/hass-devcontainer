#!/usr/bin/env bash

set -x

# Install cosign
function install_cosign() {
    curl -fLs \
        "https://github.com/sigstore/cosign/releases/download/v${COSIGN_VERSION}/cosign-linux-${DOCKER_ARCH}" \
        --output ./cosign

    sudo chmod +x ./cosign
    sudo mv -f ./cosign /usr/local/bin/cosign
    sudo rm -f ./cosign
}

# Install os-agent
function install_os_agent() {
    curl -Lso ./os-agent.deb \
        "https://github.com/home-assistant/os-agent/releases/download/${OS_AGENT_VERSION}/os-agent_${OS_AGENT_VERSION}_linux_${ARCH}.deb"

    sudo dpkg -i ./os-agent.deb
    sudo rm ./os-agent.deb
}

# Install shellcheck
function install_shellcheck() {
    curl -fLs \
        "https://github.com/koalaman/shellcheck/releases/download/stable/shellcheck-stable.linux.${ARCH}.tar.xz" \
        | tar -xJ

    sudo mv -f "./shellcheck-stable/shellcheck" "/usr/bin/shellcheck"
    sudo rm -rf "./shellcheck-stable"
}

# Prepare supervisor
echo "Prepare supervisor"
prepare_supervisor

# Install packages
echo "Install deps"
install_cosign
install_os_agent
install_shellcheck

bash /tmp/build/docker.sh