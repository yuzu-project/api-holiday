#!/bin/sh
cd build/tests
ctest
RESULT=$?
cd ../..
exit ${RESULT}
