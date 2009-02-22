pkg: mkdir -p /usr/lib
prefix=$(dirname "$(which "${PKG_TARG}-gcc")")/..
for ver in 1; do
    libgcc=lib/libgcc_s.${ver}.dylib
    cp -a "${prefix}/${PKG_TARG}/${libgcc}" "${PKG_DEST}/usr/lib"
    #pkg: "${PKG_TARG}-strip" -x -no_uuid "/usr/${libgcc}"
    #pkg: ldid -T- "/usr/${libgcc}"
done
