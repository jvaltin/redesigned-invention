#!/bin/bash
#
# This script runs inside of a Docker container
#

set -e

cd /opt && \
    wget -c https://github.com/probonopd/linuxdeployqt/releases/download/continuous/linuxdeployqt-continuous-x86_64.AppImage && \
    echo 'c068b019a2bdb616df84775054d4149ea1832ace5db1f95e0e417ef27e01f980 /opt/linuxdeployqt-continuous-x86_64.AppImage' | sha256sum -c - && \
    chmod +x /opt/linuxdeployqt-continuous-x86_64.AppImage
