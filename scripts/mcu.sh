#!/bin/bash

set -e

cd /opt/src/mcu
rm -rf build
mkdir build && cd build
cmake .. -DBUILD_TYPE=test
make
make test
cp -v ./Testing/Temporary/LastTest.log /app/build-output/
cd ../

rm -rf build
mkdir build && cd build
cmake .. -DBUILD_TYPE=firmware
make
cp -v ./bin/firmware.* /app/build-output/
cd ../

rm -rf build
mkdir build && cd build
cmake .. -DBUILD_TYPE=bootloader
make
cp -v ./bin/bootloader.* /app/build-output/
cd ../
