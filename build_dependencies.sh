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

libDir=${DEFAULT_LIB_DIRECTORY_PATH}
isDebug=0
skipTests=0

print_help(){
    echo "Usage: build_dependencies [[-d | --debug] [-j | --skip-tests] [-l | --lib-dir binary-library-path]]"
}

install_cpprestsdk(){
	restsdkDir="${libDir}/cpprestsdk"
	restsdkBuildDir="${restsdkDir}/build.release"
	restsdkBuildType="Release"
	restsdkBuildTestsToggle="OFF"
	if [ "${isDebug}" = "1" ]; then
		restsdkBuildDir="${restsdkDir}/build.debug"
		restsdkBuildType="Debug"
		if [ "${skipTests}" = "0" ]; then
			restsdkBuildTestsToggle="ON"
		fi
	fi
	restsdkOutputDir="${restsdkBuildDir}/Release/Binaries"
   
    if [ -d "${restsdkDir}" ]; then
      rm -rf "${restsdkDir}"
    fi
   
    echo -e "${COLOR_LIGHTCYAN}Downloading C++ REST SDK ${RESTSDK_VERSION}...${COLOR_NONE}"
	git clone https://github.com/Microsoft/cpprestsdk.git "${restsdkDir}"
	(cd ${restsdkDir} && git checkout tags/${RESTSDK_VERSION} -b ${RESTSDK_VERSION})
	mkdir -p "${restsdkBuildDir}"
	if [ "${OSTYPE}" = "linux-gnu" ]; then
		export CXX=g++-4.9
	fi
    echo -e "${COLOR_LIGHTCYAN}Building C++ REST SDK ${RESTSDK_VERSION}...${COLOR_NONE}"
    echo -e "${COLOR_YELLOW}-  Build type : ${restsdkBuildType}${COLOR_NONE}"
    echo -e "${COLOR_YELLOW}-  Build tests? ${restsdkBuildTestsToggle}${COLOR_NONE}"
	(cd "${restsdkBuildDir}" && cmake -G Ninja .. -DCMAKE_BUILD_TYPE=${restsdkBuildType} -DBUILD_SHARED_LIBS=OFF -DBUILD_TESTS=${restsdkBuildTestsToggle} -DBUILD_SAMPLES=OFF && ninja)
	#(cd "${restsdkBuildDir}" && make)
	if [ "${skipTests}" = "0" ]; then
	    echo -e "${COLOR_YELLOW}>>  Running tests for C++ REST SDK...${COLOR_NONE}"		
		(cd "${restsdkOutputDir}" && ./test_runner *_test.so)
		if [ "$?" != "0" ]; then
		    echo -e "${COLOR_RED}ERROR: C++ REST SDK tests failed!${COLOR_NONE}"
			exit 2
		fi
	fi
}

while [ "${1}" != "" ]; do
	case ${1} in
		-d | --debug )          isDebug=1
								;;
		-j | --skip-tests )    	skipTests=1
								;;
		-l | --lib-dir )    	shift
								libDir=${1}
								;;
		-h | --help )	    	print_help
								exit
								;;
		* )                     print_help
								exit 1
	esac
	shift
done

mkdir -p "$libDir"
install_cpprestsdk
echo -e "${COLOR_LIGHTGREEN}Done building dependencies!${COLOR_NONE}"
