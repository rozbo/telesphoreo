pkg:extract
cd *
pkg:patch
cd src
make CC=arm-apple-darwin-gcc CXX=arm-apple-darwin-g++
pkg: mkdir -p /usr/lib /usr/include
pkg: cp -a libdict.a /usr/lib
pkg: cp -a include/*.{h,hpp} /usr/include
