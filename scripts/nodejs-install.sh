#!/bin/bash

# 
# This installs the nodesource nodejs packages and needed npm libraries
#

set -e

curl -sL https://deb.nodesource.com/setup_8.x | bash -
apt install -y nodejs
npm install -g cordova
npm install -g bitcore-lib
npm install -g buffer-reverse
npm install -g browserify
