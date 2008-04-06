pkg:extract
cd *
pkg:patch
autoconf
pkg:configure
make
pkg: mkdir -p /usr/bin
pkg: cp -a srelay /usr/bin
