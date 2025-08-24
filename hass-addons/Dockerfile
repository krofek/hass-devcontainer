FROM mcr.microsoft.com/devcontainers/base:debian

# Avoid warnings by switching to noninteractive
ENV DEBIAN_FRONTEND=noninteractive \
    DEVCONTAINER=1
    
# Versions
ENV COSIGN_VERSION=2.4.0 \
    OS_AGENT_VERSION=1.7.2

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# Install Docker
COPY /hass-addons/build/docker_install.sh /docker_install.sh
RUN bash /docker_install.sh && rm /docker_install.sh

# Copy root filesystem
COPY /hass-addons/rootfs /