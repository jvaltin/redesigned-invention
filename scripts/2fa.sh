#!/bin/bash

# 
# This only builds the hmac branch for the 2FA app
#

curl -sL https://deb.nodesource.com/setup_8.x | bash -
apt install -y nodejs
npm install -g cordova
echo "deb http://deb.debian.org/debian sid main" > /etc/apt/sources.list.d/unstable.list
apt update
apt install -y -t unstable android-sdk android-sdk-platform-23 default-jre
apt install -y -t unstable openjdk-8-jdk-headless openjdk-8-jre-headless
apt install -y -t unstable android-platform-tools-base android-sdk 
apt install -y -t unstable android-sdk-helper

cd /opt/src/2FA-app/
npm install -g cordova
npm install -g bitcore-lib
npm install -g buffer-reverse
npm install -g browserify
cordova prepare
#cordova platform add browser
npm install
export JAVA_HOME="/usr/lib/jvm/java-8-openjdk-amd64/"
export ANDROID_HOME="/usr/lib/android-sdk" 
export PATH=/usr/lib/jvm/java-8-openjdk-amd64/bin/:$PATH
# Echo the sha1sum of the license text to these files to ensure gradle won't
# complain about needing to accept a license text. Without this - the build breaks.
echo -e "\n84831b9409646a918e30573bab4c9c91346d8abd" > "/usr/lib/android-sdk/licenses/android-sdk-preview-license"
echo -e "\nd56f5187479451eabf01fb78af6dfcb131a6481e" >> "/usr/lib/android-sdk/licenses/android-sdk-license"

# Patch up platforms/android/app/build.gradle
cd /opt/src/2FA-app/platforms/android/app/ && patch < /opt/src/2Fa-gradle.patch

browserify www/js/main_new.js -o www/js/app_new.js && \
   browserify www/js/init.js -o www/js/app_init.js && \
   browserify www/js/main_old.js -o www/js/app_old.js

cordova build android
cordova build browser
cp /opt/src/2FA-app/platforms/android/app/build/outputs/apk/debug/app-debug.apk /app/build-output/2FA-app-debug.apk
