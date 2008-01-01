shopt -s extglob
tar -zxvf "${PKG_DATA}/boost_1_34_1.tar.gz"
cd boost_1_34_1
pkg:patch
./configure --prefix=/usr --without-icu --without-libraries=python
echo 'using darwin ;' >user-config.jam
make
make install PREFIX="${PKG_DEST}/usr"
rm -f "${PKG_DEST}"/usr/lib/*-d?(-+([0-9_])).@(a|dylib)
for na in "${PKG_DEST}"/usr/lib/*-+([0-9_]).a; do
    a=${na/-+([0-9_]).a/.a}
    rm -f "$a"
    ln -s "$(basename "$na")" "$a"
done
