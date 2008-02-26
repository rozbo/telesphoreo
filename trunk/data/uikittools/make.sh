pkg:extract
cd *
make
pkg: mkdir -p /usr/bin
pkg: cp -a uialert /usr/bin
