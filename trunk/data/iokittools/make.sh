shopt -s extglob
tar -zxvf "${PKG_DATA}/IOKitTools-76.tar.gz"
cd IOKitTools-76
for tproj in *.tproj; do
    tproj=$(basename "${tproj}" .tproj)
    arm-apple-darwin-gcc -lcurses -o "${tproj}" "${tproj}.tproj"/*.c -framework CoreFoundation -framework IOKit
    pkg:usrbin "${tproj}"
done
