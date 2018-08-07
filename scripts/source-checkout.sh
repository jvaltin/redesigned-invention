#!/bin/bash
#
# This script runs inside of a Docker container
#

# Checkout source repos
mkdir -p /opt/src
cd /opt/src;
git clone https://github.com/digitalbitbox/bitbox-wallet-app;
git clone --recursive https://github.com/digitalbitbox/mcu;
#git clone https://github.com/digitalbitbox/2FA-app.git;

