FROM mcr.microsoft.com/devcontainers/base:debian

ENV DEBIAN_FRONTEND=noninteractive \
    DEVCONTAINER=1

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# Install tools
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        docker-ce=5:24.0.7-1~debian.12~bookworm \
        docker-ce-cli=5:24.0.7-1~debian.12~bookworm \
        containerd.io\
        docker-buildx-plugin=0.11.2-1~debian.12~bookworm \
        docker-compose-plugin=2.24.2-1~debian.12~bookworm \
    && rm -rf /var/lib/apt/lists/* \
    && usermod -aG docker "${USER:-vscode}" \
    && systemctl enable docker.service \
    && systemctl enable containerd.service

# Copy rootfs and bootstrap.sh
COPY ./src/install /tmp/install
COPY ./src/rootfs /

# Install Dependencies
RUN bash /tmp/install/install.sh

# Cleanup
RUN rm -rf /tmp/* \
    && apt-get autoremove -y \
    && apt-get clean -y