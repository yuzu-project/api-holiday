#!/bin/sh
mkdir -p build/tests
cd build/tests
cmake -G Ninja ../../test
ninja
