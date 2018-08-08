#!/bin/bash

set -e

cd /opt/src/html_backup
browserify js/backup_in.js -o js/backup.js
cp js/backup.js /app/build-output/
