pkg:extract
mv * native
pkg:extract
cd native
./configure
make
cd ../!(native)
pkg:configure
make FILE_COMPILE="$(pwd)/../native/src/file"
pkg:install
