FROM mcr.microsoft.com/devcontainers/base:debian

ENV DEBIAN_FRONTEND=noninteractive \
    DEVCONTAINER=1

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# Copy rootfs and bootstrap.sh
COPY src/install /install
COPY src/rootfs /

RUN bash deps.sh
