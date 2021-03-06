#!/bin/bash

source ../config.variables

WORKING_DIR=$(pwd)
BASEDIR=$(dirname $0)

WD=
if [[ "$BASEDIR" == '.' ]]; then
    WD=$WORKING_DIR
else
    WD=$BASEDIR
fi

url=$(jq -r .url ./build.json)
pkgversion=$(jq -r .pkgversion ./build.json)
pkgname=$(jq -r .pkgname ./build.json)
eval filename=$(jq -r .file ./build.json)

eval fullurl="$url$filename"

echo "Package Name: $pkgname"
echo "Package Version: $pkgversion"
echo "URL: ${fullurl}"

pushd $SOURCE_TREE >/dev/null
    echo "Downloading ${fullurl}"
    curl -L -# --url ${fullurl} --output ${filename}
    echo "Unpacking ${filename}"
    tar xvf ${filename}
    pushd "${pkgname}-${pkgversion}" >/dev/null
        patch -p1 <"$WD/gnulib-libio.patch"
        echo "Compiling ${pkgname}"
        ./configure --prefix=$TARGET_DIRECTORY
        make
        echo "Installing ${pkgname}"
        make install
    popd >/dev/null
popd >/dev/null