#!/bin/bash
set -euxo pipefail

export DEBIAN_FRONTEND=noninteractive

# Install required utils
apt-get update
apt-get install -y --no-install-recommends \
  apt-transport-https \
  ca-certificates \
  curl \
  dirmngr \
  git \
  gnupg \
  jq \
  lsb-release \
  make

# Download latest release of inner-runner
DOWNLOAD=$(curl -sSfL https://api.github.com/repos/repo-runner/repo-runner/releases/latest |
	jq -r '.assets | .[] | select(.name == "inner-runner_linux_amd64.tar.gz") | .browser_download_url')
curl -sSfL "${DOWNLOAD}" | tar -xzf - -C /usr/local/bin
mv /usr/local/bin/inner-runner* /usr/local/bin/inner-runner

# Install docker-ce
apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 9DC858229FC7DD38854AE2D88D81803C0EBFCD88

echo "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -sc) stable" >/etc/apt/sources.list.d/docker.list
apt-get update
apt-get install -y --no-install-recommends docker-ce

# Cleanup
apt-get purge -y \
  dirmngr \
  gnupg \
  jq \
  lsb-release
apt-get autoremove --purge -y
rm -rf /var/lib/apt/lists/*
