#!/bin/bash

COLOR_NONE="\033[0m"
COLOR_RED="\033[0;31m"
COLOR_CYAN="\033[0;36m"
COLOR_YELLOW="\033[1;33m"
COLOR_WHITE="\033[1;37m"
COLOR_LIGHTCYAN="\033[1;36m"
COLOR_LIGHTGREEN="\033[1;32m"

RESTSDK_VERSION="v2.10.14"
DEFAULT_LIB_DIRECTORY_PATH="./libs"

libDir=${1:-$DEFAULT_LIB_DIRECTORY_PATH}

install_cpprestsdk(){
	restsdkDir="$libDir/cpprestsdk"
	restsdkBuildDir="$restsdkDir/build.release"
   
    if [ -d "$restsdkDir" ]; then
      rm -rf "$restsdkDir"
    fi
   
    echo -e "${COLOR_LIGHTCYAN}Downloading C++ REST SDK ${RESTSDK_VERSION}...${COLOR_NONE}"
	git clone https://github.com/Microsoft/cpprestsdk.git "${restsdkDir}"
	(cd $restsdkDir && git checkout tags/$RESTSDK_VERSION -b $RESTSDK_VERSION)
	mkdir -p "$restsdkBuildDir"
	if [[ "$OSTYPE" == "linux-gnu" ]]; then
		export CXX=g++-4.9
	fi
    echo -e "${COLOR_LIGHTCYAN}Building C++ REST SDK $RESTSDK_VERSION...${COLOR_NONE}"
	(cd "$restsdkBuildDir" && cmake ../Release -DCMAKE_BUILD_TYPE=Release -DBUILD_SHARED_LIBS=OFF -DBUILD_TESTS=OFF -DBUILD_SAMPLES=OFF)
	(cd "$restsdkBuildDir" && make)
}

mkdir -p "$libDir"
install_cpprestsdk
echo -e "${COLOR_LIGHTGREEN}Done building dependencies!${COLOR_NONE}"
