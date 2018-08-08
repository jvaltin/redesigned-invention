#!/bin/bash
#
# This script runs inside of a Docker container
#

set -e

# Checkout source repos
mkdir -p /opt/src
cd /opt/src;
git clone https://github.com/digitalbitbox/bitbox-wallet-app;
git clone --recursive https://github.com/digitalbitbox/mcu;
git clone https://github.com/digitalbitbox/2FA-app;
git clone https://github.com/digitalbitbox/html_backup
git clone https://github.com/digitalbitbox/ElectronDemo
