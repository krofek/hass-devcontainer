FROM mcr.microsoft.com/devcontainers/base:debian

ENV DEBIAN_FRONTEND=noninteractive \
    DEVCONTAINER=1

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# Install Docker
COPY /hass-addons/build/docker_install.sh /docker_install.sh
RUN bash /docker_install.sh && rm /docker_install.sh

COPY /hass-addons/rootfs /