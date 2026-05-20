#!/bin/bash

set -eo pipefail

apt-get update

# Base packages
apt-get install -y htop openssh-server git curl \
  apache2 dkms build-essential linux-headers-$(uname -r)

# XFCE desktop environment
apt-get install -y xfce4 xfce4-goodies lightdm

# Docker
apt-get install -y ca-certificates gnupg lsb-release
install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg
chmod a+r /etc/apt/keyrings/docker.gpg

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian \
  $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null

apt-get update
apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Allow vagrant user to run Docker without sudo
usermod -aG docker vagrant

systemctl enable docker
systemctl enable lightdm
