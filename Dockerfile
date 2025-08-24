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
COPY ./src/bootstrap.sh /tmp/bootstrap.sh

# Bootstrap
RUN bash /tmp/bootstrap.sh && rm -rf /tmp/bootstrap.sh

# Cleanup
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*  /var/cache/apt/archives/*.deb
