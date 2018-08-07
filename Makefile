build: build-world build-mcu build-bitbox-wallet-app build-2fa
	echo "Build completed:"
	ls -al build-output/

build-world:
	docker run hello-world
	cd src && rm -rf 2FA-app-hmac_bitbox && unzip 2FA-app-hmac_bitbox.zip && cd ../;
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
           --privileged -v /dev/bus/usb:/dev/bus/usb \
           --interactive --tty \
           -p 8080:8080 -p 8082:8082 \
           --add-host="dev.shiftcrypto.ch:176.9.28.202" \
           --add-host="dev1.shiftcrypto.ch:176.9.28.155" \
           --add-host="dev2.shiftcrypto.ch:176.9.28.156" \
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
	- rm build-output/BitBox-x86_64.AppImage
	- rm build-output/LastTest.log

