#!/bin/bash
#
# This script was tested on Ubuntu Xenial.
# It should install all packages required to use Docker.
# 

set -e

RELEASE=$(lsb_release -cs)
apt install -y apt-transport-https ca-certificates curl \
	           software-properties-common
apt-key add keys/docker.gpg
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $RELEASE stable"
apt update
apt install -y docker-ce
docker run hello-world
echo "$?"
echo "Docker should be ready for use"
