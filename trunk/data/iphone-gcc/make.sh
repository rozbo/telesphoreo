shopt -s extglob
pkg:setup
mkdir ../llvm-gcc-bld
cd ../llvm-gcc-bld
PKG_CONF=../llvm-gcc-4.2/configure pkg:configure \
    --enable-languages="c,c++,objc,obj-c++" \
    --enable-wchar_t="no" \
    --with-gxx-include-dir="/usr/include/c++/4.0.0"
make -j3
pkg:install
pkg: rm -f /usr/lib/libgcc_s.1.dylib
pkg: rm -f /usr/lib/libiberty.a
