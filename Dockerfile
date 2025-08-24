FROM mcr.microsoft.com/devcontainers/base:debian

ENV DEBIAN_FRONTEND=noninteractive \
    DEVCONTAINER=1

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

COPY src/rootfs /
COPY src/install /install

RUN bash /install/install_deps.sh
