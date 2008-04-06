#!/bin/bash
set -e
shopt -s extglob
for package in data/!(*_|cydia|ui*|iphone-python|llvm-gcc|mobileterminal|nethack); do
    PKG_NAME=$(basename "${package}")
    echo "========== ${PKG_NAME} =========="
    ./make.sh "${PKG_NAME}"
done
