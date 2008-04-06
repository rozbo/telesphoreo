pkg:extract
cd *
pkg:configure
make CC="${PKG_TARG}"-gcc
pkg:install
