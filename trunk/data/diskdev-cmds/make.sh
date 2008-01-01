shopt -s extglob
tar -zxvf "${PKG_DATA}/diskdev_cmds-419.tar.gz"
cd diskdev_cmds-419
cd disklib
rm -f mntopts.h getmntopts.c
arm-apple-darwin-gcc -c *.c
arm-apple-darwin-ar -r libdisk.a *.o
cd ..
for tproj in !(fstyp|dev_mkdb|dump|fsck_hfs|fuser|mount_hfs|restore|quotacheck|ufs).tproj; do
    tproj=$(basename "${tproj}" .tproj)
    echo ${tproj}
    arm-apple-darwin-gcc -Idisklib -o "${tproj}" $(find "${tproj}.tproj" -name '*.c') disklib/libdisk.a -framework IOKit -framework CoreFoundation -lutil
    pkg:usrbin "${tproj}"
done
cd fstyp.tproj
for c in *.c; do
    bin=$(basename "${c}" .c)
    arm-apple-darwin-gcc -o "${bin}" "${c}"
    pkg:usrbin "${bin}"
done
