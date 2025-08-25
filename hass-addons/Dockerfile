FROM mcr.microsoft.com/devcontainers/base:debian

# Avoid warnings by switching to noninteractive
ENV DEBIAN_FRONTEND=noninteractive \
    DEVCONTAINER=1

# Package Versions
ENV COSIGN_VERSION=2.4.0 \
    OS_AGENT_VERSION=1.7.2

# Other ENV vars
ENV DOCKER_TIMEOUT=30 \
    SUPERVISOR_SHARE="/mnt/supervisor"

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

COPY /hass-addons/rootfs /
COPY /hass-addons/build /tmp/build

RUN source /tmp/build/vars.sh

RUN bash /tmp/build/prepare.sh && rm -rf /tmp/build