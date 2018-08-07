#!/bin/bash

cd /opt/src/bitbox-wallet-app/

mkdir -p $GOPATH/src/github.com/digitalbitbox/
cp -arv /opt/src/bitbox-wallet-app/ $GOPATH/src/github.com/digitalbitbox/
cd $GOPATH/src/github.com/digitalbitbox/bitbox-wallet-app/
make init
make qt-linux
cp -v /opt/go/src/github.com/digitalbitbox/bitbox-wallet-app/frontends/qt/build/linux/* /app/build-output/

