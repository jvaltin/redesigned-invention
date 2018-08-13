FROM debian:stretch
ENV DEBIAN_FRONTEND noninteractive
WORKDIR /app
COPY . /app

RUN apt-get update
RUN apt-get install -y --no-install-recommends apt-transport-https apt-utils ca-certificates gnupg wget
RUN echo "deb https://deb.debian.org/debian/ stretch-backports main contrib non-free" > /etc/apt/sources.list.d/backports.list
RUN apt-key add /app/keys/yarn.gpg
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" > /etc/apt/sources.list.d/yarn.list
RUN apt-get update

RUN apt-get install -y --no-install-recommends \
    astyle \
    bash-completion  \
    bash-completion \
    bison \
    build-essential \
    ccache \
    clang \
    cmake \
    curl \
    dbus \
    default-jdk \
    default-jre \
    dnsutils \
    doxygen \
    file \
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
    libcups2 \
    libcups2-dev \
    libdbus-1-dev \
    libdrm-dev \
    libegl1-mesa-dev \
    libfontconfig1-dev \
    libfreetype6-dev \
    libgbm-dev \
    libgconf-2-4 \
    libgcrypt11-dev \
    libgl1-mesa-dev \
    libglu1-mesa-dev \
    'libgstreamer*-dev' \
    'libgstreamer-plugins-base*-dev' \
    libgtk-3-dev \
    libhidapi-dev \
    libicu-dev \
    libnewlib-arm-none-eabi \
    libnewlib-dev  \
    libnss3-dev \
    libpci-dev \
    libpulse-dev \
    libsm-dev \
    libssl1.0-dev \
    libstdc++-arm-none-eabi-newlib \
    libudev-dev \
    libwayland-dev \
    libx11-dev \
    libx11-xcb-dev \
    '^libxcb.*' \
    libxcb-cursor-dev \
    libxcb-glx0-dev \
    libxcb-icccm4 \
    libxcb-icccm4-dev \
    libxcb-image0 \
    libxcb-keysyms1 \
    libxcb-keysyms1-dev \
    libxcb-randr0-dev \
    libxcb-render-util0 \
    libxcb-sync-dev \
    libxcb-xfixes0-dev \
    libxcb-xinerama0 \
    libxcb-xinerama0-dev \
    libxcb-xkb-dev  \
    libxcomposite-dev \
    libxcursor-dev \
    libxdamage-dev \
    libxext-dev \
    libxfixes-dev \
    libxi-dev \
    libxkbcommon-dev \
    libxkbcommon-x11-0 \
    libxkbcommon-x11-dev \
    libxrandr-dev \
    libxrender-dev \
    libxslt-dev \
    libxss-dev \
    libxtst-dev \
    make \
    net-tools \
    ninja-build \
    nodejs \
    openjdk-8-jdk-headless \
    python \
    rpm \
    ruby \
    ruby-dev \
    sudo \
    valgrind \
    vim \
    wget

RUN apt-get install -y --no-install-recommends yarn
RUN apt-get install -y --no-install-recommends libssl1.0-dev
RUN gem install --no-ri --no-rdoc fpm
RUN /app/scripts/nodejs-install.sh

RUN cd /opt && \
    wget -c https://github.com/probonopd/linuxdeployqt/releases/download/continuous/linuxdeployqt-continuous-x86_64.AppImage && \
    echo 'c068b019a2bdb616df84775054d4149ea1832ace5db1f95e0e417ef27e01f980 /opt/linuxdeployqt-continuous-x86_64.AppImage' | sha256sum -c - && \
    chmod +x /opt/linuxdeployqt-continuous-x86_64.AppImage

RUN cd /tmp && \
	wget https://download.qt.io/archive/qt/5.8/5.8.0/single/qt-everywhere-opensource-src-5.8.0.tar.gz && \
	tar -xf qt-everywhere-opensource-src-5.8.0.tar.gz && \
	mv qt-everywhere-opensource-src-5.8.0 qt5

RUN cd /tmp/qt5 && \
	./configure \
	  -prefix /opt/qt5 \
	  -opensource \
	  -confirm-license \
	  -nomake tests \
	  -nomake examples \
	  -dbus \
	  -xcb \
	  -system-xcb \
	  -qpa xcb \
	  -release \
	  -reduce-relocations \
	  -optimized-qmake


RUN cd /tmp/qt5 && make -j"`nproc`"
RUN cd /tmp/qt5 && make install

ENV GOPATH /opt/go
ENV GOROOT /usr/lib/go-1.10/
ENV PATH /usr/lib/jvm/java-8-openjdk-amd64/bin/:/usr/lib/go-1.10/bin:/bin:$GOROOT/bin:$GOPATH/bin:/opt/qt5/bin:$PATH

RUN /app/scripts/nodejs-install.sh

ENV JAVA_HOME="/usr/lib/jvm/java-8-openjdk-amd64/"
ENV ANDROID_HOME="/usr/lib/android-sdk"

RUN /app/scripts/android-sdk.sh

RUN /app/scripts/go-prep.sh

RUN /app/scripts/source-checkout.sh

CMD ["bash"]
