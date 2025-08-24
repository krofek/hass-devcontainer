FROM mcr.microsoft.com/devcontainers/base:debian

ENV \
    DEBIAN_FRONTEND=noninteractive \
    DEVCONTAINER=1

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# Install tools
RUN \
    apt-get update \
    && apt-get install -y --no-install-recommends \
        # dbus \
        # network-manager \
        libpulse0 \
        xz-utils

# Copy rootfs and bootstrap.sh
COPY ./src/rootfs /
COPY ./src/install /tmp/install

# Bootstrap
RUN chmod +x /tmp/install/*.sh \
    && bash /tmp/install/install.sh \
    && rm -rf /var/lib/apt/lists/* \
        /tmp/* \
        /var/tmp/* \
        /var/cache/apt/archives/*.deb
