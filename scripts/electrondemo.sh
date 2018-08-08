#!/bin/bash

set -e

cd /opt/src/ElectronDemo
yarn install
# The following step does not function inside of our Docker
yarn start
