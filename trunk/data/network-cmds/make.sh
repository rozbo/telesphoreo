shopt -s extglob
pkg:setup
for tproj in !(natd|ping|rarpd|spray).tproj; do
    tproj=$(basename "${tproj}" .tproj)
    "${PKG_TARG}-gcc" -o "${tproj}" "${tproj}.tproj"/*.c -DPRIVATE -Dether_ntohost=_old_ether_ntohost
    pkg:usrbin "${tproj}"
done
"${PKG_TARG}-gcc" -Ialias -o natd natd.tproj/*.c alias/*.c -DPRIVATE
pkg:usrbin natd
