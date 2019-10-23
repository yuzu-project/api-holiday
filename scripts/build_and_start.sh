#!/bin/sh
cd /app/build/default
cmake -G Ninja ../../src
ninja
/app/build/default/cpprest-basic-sample
