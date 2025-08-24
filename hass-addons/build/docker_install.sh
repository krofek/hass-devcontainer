#!/usr/bin/env bash

apt-get update
apt-get install -y --no-install-recommends \
    dbus \
    network-manager \
    libpulse0 \
    xz-utils
    ca-certificates \
    curl \
    gnupg \
    systemd-journal-remote

install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg
chmod a+r /etc/apt/keyrings/docker.gpg

 # shellcheck disable=SC1091
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  tee /etc/apt/sources.list.d/docker.list > /dev/null

apt-get update 
apt-get install -y --no-install-recommends \
    docker-ce \
    docker-ce-cli \
    containerd.io

rm -rf /var/lib/apt/lists/*

# Enable Docker and Containerd services
# sudo systemctl enable docker.service
# sudo systemctl enable containerd.service