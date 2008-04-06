pkg:extract
cd *
pkg:patch
RANLIB=$(which "${PKG_TARG}-ranlib") CC=$(which "${PKG_TARG}-gcc") pkg:configure
make
mkdir -p "${PKG_DEST}/usr/share"
pkg:install
