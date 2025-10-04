#!/usr/bin/env bash

# Get architecture in different formats
function get_arch()
{
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

ARCH=$(get_arch)
DOCKER_ARCH=$(get_arch "docker")
HA_ARCH=$(get_arch "ha")
QEMU_ARCH=$(get_arch "qemu")

export ARCH
export DOCKER_ARCH
export HA_ARCH
export QEMU_ARCH
