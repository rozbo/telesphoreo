pkg:setup
./configure \
    --prefix=/usr --enable-gpl --enable-postproc --enable-swscale \
    --disable-vhook --enable-avfilter --enable-avfilter-lavf \
    --enable-cross-compile --cross-prefix=${PKG_TARG}- --target-os=darwin \
    --arch=arm --disable-iwmmxt --enable-armv5te --enable-armv6 \
    --enable-static --disable-shared --disable-debug --disable-stripping \
    --enable-libfaac \
    --enable-libfaad \
    --enable-libmp3lame \
    --enable-libvorbis \
    --enable-libx264
make
pkg:install
