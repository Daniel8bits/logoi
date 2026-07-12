#!/usr/bin/env bash
set -euo pipefail

sudo apt-get update -qq
sudo apt-get install -y --no-install-recommends \
  clang \
  cmake \
  ninja-build \
  pkg-config \
  libgtk-3-dev \
  libblkid-dev \
  liblzma-dev \
  libsecret-1-dev \
  libkeybinder-3.0-dev
