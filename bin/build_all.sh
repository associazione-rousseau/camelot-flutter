#!/bin/sh

if [[ $# -ne 2 ]] ; then
    echo "[USAGE] $0 version_name version_number"
    echo "E.g.: $0 1.0.3 3"
    exit -1
fi

source ./bin/util.sh

VERSION_NAME=$1
VERSION_NUMBER=$2

echo_colored "Building Version $VERSION_NUMBER ($VERSION_NAME)" $GREEN

bin/build_ios.sh $VERSION_NAME $VERSION_NUMBER
bin/build_android.sh $VERSION_NAME $VERSION_NUMBER
