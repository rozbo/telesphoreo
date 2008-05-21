pkg:setup
./configure \
    --cross-compile --cross-prefix=${PKG_TARG}- --target-os=darwin \
    --arch=arm --disable-iwmmxt --enable-armv5te --enable-armv6 \
    --enable-static --disable-shared --disable-debug --prefix=/usr --enable-gpl \
    --enable-libfaac \
    --enable-libfaad \
    --enable-libmp3lame \
    --enable-libvorbis \
    --enable-libx264
make
pkg:install
