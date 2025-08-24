FROM mcr.microsoft.com/devcontainers/base:debian

ENV DEBIAN_FRONTEND=noninteractive \
    DEVCONTAINER=1

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# Install tools
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        # dbus=<version> \
        # network-mana3ger=<version> \
        libpulse0 \
        xz-utils \
    && rm -rf /var/lib/apt/lists/*

# Copy rootfs and bootstrap.sh
COPY ./src /

# Bootstrap
RUN bash /install/install.sh

# Cleanup
RUN rm -rf /tmp/* \
    && apt-get remove -y --purge \
        xz-utils \
    && apt-get autoremove -y \
    && apt-get clean -y