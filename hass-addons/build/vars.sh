#!/usr/bin/env bash

set -x

declare arch

# Get architecture in different formats
function get_arch()
{
    local mode=${1:-unix}

    case ${arch} in
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

ARCH=get_arch
export ARCH

DOCKER_ARCH=get_arch docker
export DOCKER_ARCH

HA_ARCH=get_arch ha
export HA_ARCH

QEMU_ARCH=get_arch qemu
export QEMU_ARCH

VERSION_INFO=$(curl -s https://version.home-assistant.io/dev.json)
export VERSION_INFO

SUPERVISOR_VERSION="$(echo "${VERSION_INFO}" | jq -e -r '.supervisor')"
export SUPERVISOR_VERSION

# shellcheck disable=SC2001
SUPERVISOR_IMAGE="$(sed "s/{arch}/${HA_ARCH}/g" <<< "$(echo "${VERSION_INFO}" | jq -e -r '.images.supervisor')")"
export SUPERVISOR_IMAGE
