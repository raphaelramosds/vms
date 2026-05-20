#!/bin/bash

set -e pipefail

sudo apt update

sudo apt install -y apache2 dkms build-essential linux-headers-$(uname -r) htop