shopt -s extglob
pkg:setup
for tproj in *.tproj; do
    tproj=$(basename "${tproj}" .tproj)
    ${PKG_TARG}-gcc -lcurses -o "${tproj}" "${tproj}.tproj"/*.c -framework CoreFoundation -framework IOKit
    pkg:usrbin "${tproj}"
done
