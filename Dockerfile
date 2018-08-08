FROM debian:buster
RUN apt-get update
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get install -y --no-install-recommends apt-transport-https apt-utils ca-certificates gnupg wget
WORKDIR /app
COPY . /app
RUN cd /opt && \
    wget -c https://github.com/probonopd/linuxdeployqt/releases/download/continuous/linuxdeployqt-continuous-x86_64.AppImage && \
    echo 'c068b019a2bdb616df84775054d4149ea1832ace5db1f95e0e417ef27e01f980 /opt/linuxdeployqt-continuous-x86_64.AppImage' | sha256sum -c - && \
    chmod +x /opt/linuxdeployqt-continuous-x86_64.AppImage
RUN apt-get install -y --no-install-recommends \
	astyle \
	bash-completion  \
	bison \
	build-essential \
	ccache \
	clang \
	cmake \
	crossbuild-essential-amd64 \
	curl \
	default-jdk \
	default-jre \
	dnsutils \
	doxygen \
	flex \
	fuse \
	g++ \
	gcc \
	gcc-arm-none-eabi  \
	git \
	golang-1.10-go \
	gperf \
	graphviz \
	gyp \
	less \
	libasound2-dev \
	libatspi2.0-dev \
	libbz2-dev \
	libc6-dev \
	libcap-dev \
	libcups2  \
	libcups2-dev \
	libdbus-1-dev \
	libdrm-dev \
	libegl1-mesa-dev \
	libegl1-mesa-dev  \
	libfontconfig1-dev \
	libfreetype6-dev \
        libgconf-2-4 \
	libgcrypt11-dev \
	libgl1-mesa-dev \
	libglu1-mesa-dev \
	'libgstreamer*-dev' \
	'libgstreamer-plugins-base*-dev' \
	libhidapi-dev \
	libicu-dev \
	libnewlib-arm-none-eabi \
	libnewlib-dev  \
	libnss3-dev \
	libpci-dev \
	libpulse-dev \
	libqt5webenginewidgets5 \
	libqt5webkit5-dev \
	libssl1.0-dev \
	libstdc++-arm-none-eabi-newlib \
	'libstdc++.*dev' \
	libudev-dev \
	libx11-dev \
	libx11-xcb-dev \
	'^libxcb.*' \
	libxcb-icccm4 \
	libxcb-image0  \
	libxcb-keysyms1 \
	libxcb-render-util0 \
	libxcb-xinerama0 \
	libxcb-xkb-dev  \
	libxcomposite-dev \
	libxcursor-dev \
	libxdamage-dev \
	libxext-dev \
	libxfixes-dev \
	libxi-dev \
	libxrandr-dev \
	libxrender-dev \
	libxrender-dev  \
	libxslt-dev \
	libxslt-dev  \
	libxss-dev \
	libxtst-dev \
	make \
	net-tools \
	ninja-build \
	nodejs \
	openjdk-8-jdk-headless \
	python \
	qml-module-qtwebengine  \
	qt5-default  \
	qtwebengine5-dev \
	rpm \
	ruby \
	ruby-dev \
	sudo \
	valgrind \
	vim \
	wget \
	&& apt-get autoremove && apt-get clean

RUN apt-key add /app/keys/yarn.gpg
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" > /etc/apt/sources.list.d/yarn.list
RUN apt-get update && apt-get install -y --no-install-recommends yarn
RUN gem install --no-ri --no-rdoc fpm

ENV GOPATH /opt/go
ENV GOROOT /usr/lib/go-1.10/
ENV PATH /usr/lib/jvm/java-8-openjdk-amd64/bin/:/usr/lib/go-1.10/bin:/bin:$GOROOT/bin:$GOPATH/bin:/opt/qt5/bin:$PATH

RUN /app/scripts/nodejs-install.sh
RUN /app/scripts/android-sdk.sh

ENV JAVA_HOME="/usr/lib/jvm/java-8-openjdk-amd64/"
ENV ANDROID_HOME="/usr/lib/android-sdk"

RUN /app/scripts/go-prep.sh
RUN /app/scripts/source-checkout.sh

COPY src/ /opt/src/

ENV CC /bin/clang
ENV CXX /bin/clang++;
ENV ARCH x86_64

CMD ["bash"]
