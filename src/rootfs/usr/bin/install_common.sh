#!/usr/bin/env bash

set -x

# Get architecture in different formats
function get_arch() {
    local mode=${1:-unix}
    case $(arch) in
        x86_64|amd64)
          case $mode in
              unix)
                echo "x86_64";;
              docker|ha)
                echo "amd64";;
              qemu)
                echo "x86-64";;
          esac
        ;;
        aarch64|arm64)
          case $mode in
              unix|ha)
                echo "aarch64";;
              docker)
                echo "arm64";;
              qemu)
                echo "arm-64";;
          esac
        ;;
    esac
}

export get_arch
export get_package_version

# Prepare supervisor
function prepare_supervisor() {
    sudo rm /etc/machine-id
    sudo dbus-uuidgen --ensure=/etc/machine-id

    if grep -q 'microsoft-standard\|standard-WSL' /proc/version; then
        # The docker daemon does not start when running WSL2 without adjusting iptables
        sudo update-alternatives --set iptables /usr/sbin/iptables-legacy || echo "Fails adjust iptables"
        sudo update-alternatives --set ip6tables /usr/sbin/ip6tables-legacy || echo "Fails adjust ip6tables"
    fi
}

# Install cosign
function install_cosign() {
    ARCH=$(get_arch docker)

    curl -fLs \
        "https://github.com/sigstore/cosign/releases/download/v${COSIGN_VERSION}/cosign-linux-${ARCH}" \
        --output ./cosign

    sudo chmod +x ./cosign
    sudo mv -f ./cosign /usr/local/bin/cosign
    sudo rm -f ./cosign
}

# Install os-agent
function install_os_agent() {
    ARCH=$(get_arch)

    curl -Lso ./os-agent.deb \
        "https://github.com/home-assistant/os-agent/releases/download/${OS_AGENT_VERSION}/os-agent_${OS_AGENT_VERSION}_linux_${ARCH}.deb"

    sudo dpkg -i ./os-agent.deb
    sudo rm ./os-agent.deb
}

# Install shellcheck
function install_shellcheck() {
    ARCH=$(get_arch)
    
    curl -fLs \
        "https://github.com/koalaman/shellcheck/releases/download/stable/shellcheck-stable.linux.${ARCH}.tar.xz" \
        | tar -xJ

    sudo mv -f "./shellcheck-stable/shellcheck" "/usr/bin/shellcheck"
    sudo rm -rf "./shellcheck-stable"
}