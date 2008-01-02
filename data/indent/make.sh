pkg:extract
cd *
pkg:patch
pkg:configure
cd man
make CC=gcc
cd ..
make
pkg:install
