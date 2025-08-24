FROM mcr.microsoft.com/devcontainers/base:debian

ENV DEBIAN_FRONTEND=noninteractive \
    DEVCONTAINER=1

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# Copy rootfs and bootstrap.sh
COPY ./src/install /tmp/install
COPY ./src/rootfs /

# Install Dependencies
RUN bash /tmp/install/install.sh

# Cleanup
RUN rm -rf /tmp/* \
    && apt-get autoremove -y \
    && apt-get clean -y