build: build-world build-mcu build-bitbox-wallet-app build-2fa
	echo "Build completed:"
	ls -al build-output/

build-world:
	- mkdir build-output
	docker run hello-world
	docker build --pull -t build-world .

install-docker:
	sudo ./scripts/install-docker.sh 

docker-shell:
	docker run \
        -a stdin -a stdout -i \
        --mount src="`pwd`/build-output/",target=/app/build-output/,type=bind \
        -t build-world:latest /bin/bash

build-mcu:
	docker run \
        -a stdin -a stdout -i \
        --mount src="`pwd`/build-output/",target=/app/build-output/,type=bind \
        -t build-world:latest \
	/app/scripts/mcu.sh

build-bitbox-wallet-app:
	docker run \
        -a stdin -a stdout -i \
        --privileged \
        --interactive --tty \
        --mount src="`pwd`/build-output/",target=/app/build-output/,type=bind \
	-v \
	-t build-world:latest \
        /app/scripts/bitbox-wallet-app.sh

build-2fa:
	docker run \
	-a stdin -a stdout -i \
	--mount src="`pwd`/build-output/",target=/app/build-output/,type=bind \
	-t build-world:latest \
	/app/scripts/2fa.sh

clean:
	- rm build-output/*.apk
	- rm build-output/*.rpm
	- rm build-output/*.deb
	- rm build-output/firmware.*
	- rm build-output/bootloader.*
	- rm build-output/BitBox-x86_64.AppImage
	- rm build-output/LastTest.log

