#!/bin/bash

# 
# This adds the android-sdk and jdk/jre packages
#

set -e

echo "deb http://deb.debian.org/debian sid main" > /etc/apt/sources.list.d/unstable.list
apt update
apt install -y -t unstable android-sdk android-sdk-platform-23 default-jre
apt install -y -t unstable openjdk-8-jdk-headless openjdk-8-jre-headless
apt install -y -t unstable android-platform-tools-base android-sdk 
apt install -y -t unstable android-sdk-helper

export JAVA_HOME="/usr/lib/jvm/java-8-openjdk-amd64/"
export ANDROID_HOME="/usr/lib/android-sdk" 
export PATH=/usr/lib/jvm/java-8-openjdk-amd64/bin/:$PATH
# Echo the sha1sum of the license text to these files to ensure gradle won't
# complain about needing to accept a license text. Without this - the build breaks.
echo -e "\n84831b9409646a918e30573bab4c9c91346d8abd" > "/usr/lib/android-sdk/licenses/android-sdk-preview-license"
echo -e "\nd56f5187479451eabf01fb78af6dfcb131a6481e" >> "/usr/lib/android-sdk/licenses/android-sdk-license"
