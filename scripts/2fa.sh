#!/bin/bash

set -e

cd /opt/src/2FA-app/
cordova prepare
npm install

cordova platform add android
# Patch up platforms/android/app/build.gradle
cd /opt/src/2FA-app/platforms/android/app/ && patch < /opt/src/2Fa-gradle.patch
cd /opt/src/2FA-app/

browserify www/js/main_new.js -o www/js/app_new.js && \
   browserify www/js/init.js -o www/js/app_init.js && \
   browserify www/js/main_old.js -o www/js/app_old.js

cordova build android
cordova build browser
cp /opt/src/2FA-app/platforms/android/app/build/outputs/apk/debug/app-debug.apk /app/build-output/2FA-app-debug.apk
