#!/bin/bash

#Cd expat-2.2.0
cd ./expat-2.2.0

#Import cross compile tool
CROSS_COMPILE_ENVIRONMENT_HOME=/opt/fsl-imx-x11/3.14.52-1.1.0
source ${CROSS_COMPILE_ENVIRONMENT_HOME}/environment-setup-cortexa7hf-vfp-neon-poky-linux-gnueabi

#Build for imx6ul board
./configure --prefix=/usr --host=arm-poky-linux-gnueabi
make
make install DESTDIR=${PWD}/imx6ul

#Build for crosscompile tool
make clean
make distclean
./configure --prefix=${CROSS_COMPILE_ENVIRONMENT_HOME}/sysroots/cortexa7hf-vfp-neon-poky-linux-gnueabi/usr --host=arm-poky-linux-gnueabi
make
make install

#Release
cd ..
mkdir -p release
mkdir -p release/usr
mkdir -p release/usr/lib

cp -R ./expat-2.2.0/imx6ul/usr/bin ./release/usr
cp -R ./expat-2.2.0/imx6ul/usr/lib/*.so* ./release/usr/lib

