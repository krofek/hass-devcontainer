#!/usr/bin/env bash

set -x

# Get architecture in different formats
function get_arch()
{
    local mode=${1:-unix}

    case $TARGETPLATFORM in
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

export ARCH
ARCH=get_arch

export DOCKER_ARCH
DOCKER_ARCH=get_arch docker

export HA_ARCH
HA_ARCH=get_arch ha

export QEMU_ARCH
QEMU_ARCH=get_arch qemu

export VERSION_INFO
VERSION_INFO=$(curl -s https://version.home-assistant.io/dev.json)

export SUPERVISOR_VERSION
SUPERVISOR_VERSION="$(echo "${VERSION_INFO}" | jq -e -r '.supervisor')"

export SUPERVISOR_IMAGE
SUPERVISOR_IMAGE="$(sed "s/{arch}/${HA_ARCH}/g" <<< "$(echo "${VERSION_INFO}" | jq -e -r '.images.supervisor')")"
