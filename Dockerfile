FROM mcr.microsoft.com/devcontainers/base:debian

ENV DEBIAN_FRONTEND=noninteractive \
    DEVCONTAINER=1

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# Install tools
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        # dbus \
        # network-mana3ger \
        libpulse0=17.0 \
        xz-utils=5.8 \
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