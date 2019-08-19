#!/bin/bash

RESTSDK_VERSION="v2.10.14"
DEFAULT_LIB_DIRECTORY_PATH="./libs"

libDir=${1:-$DEFAULT_LIB_DIRECTORY_PATH}

install_cpprestsdk(){
	restsdkDir="$libDir/cpprestsdk"
	restsdkBuildDir="$restsdkDir/build.release"
   
    if [ -d "$restsdkDir" ]; then
      rm -rf "$restsdkDir"
    fi
   
    echo "Downloading C++ REST SDK $RESTSDK_VERSION..."
	git clone https://github.com/Microsoft/cpprestsdk.git "$restsdkDir"
	(cd $restsdkDir && git checkout tags/$RESTSDK_VERSION -b $RESTSDK_VERSION)
	mkdir -p "$restsdkBuildDir"
	if [[ "$OSTYPE" == "linux-gnu" ]]; then
		export CXX=g++-4.9
	fi
    echo "Downloading C++ REST SDK $RESTSDK_VERSION..."
	(cd "$restsdkBuildDir" && cmake ../Release -DCMAKE_BUILD_TYPE=Release -DBUILD_SHARED_LIBS=OFF -DBUILD_TESTS=OFF -DBUILD_SAMPLES=OFF)
	(cd "$restsdkBuildDir" && make)
}

mkdir -p "$libDir"
install_cpprestsdk