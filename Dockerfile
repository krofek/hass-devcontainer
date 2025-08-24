FROM mcr.microsoft.com/devcontainers/base:debian

ENV DEBIAN_FRONTEND=noninteractive \
    DEVCONTAINER=1

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# RUN apt-get update \
#     && apt-get install -y --no-install-recommends \
#         udisks2

# Copy rootfs and bootstrap.sh
COPY ./src/install /install
COPY ./src/rootfs /
