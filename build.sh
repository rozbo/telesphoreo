#!/bin/bash
set -e
shopt -s extglob
for package in data/!(*_); do
    PKG_NAME=$(basename "${package}")
    ./package.sh "${PKG_NAME}"
done
