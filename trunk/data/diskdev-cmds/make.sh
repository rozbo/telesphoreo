shopt -s extglob
pkg:extract
cd *

cd disklib
rm -f mntopts.h getmntopts.c
arm-apple-darwin-gcc -c *.c
arm-apple-darwin-ar -r libdisk.a *.o
cd ..

for tproj in !(fstyp|dev_mkdb|dump|fsck_hfs|fuser|mount_hfs|restore|quotacheck|ufs).tproj; do
    tproj=$(basename "${tproj}" .tproj)
    echo ${tproj}
    arm-apple-darwin-gcc -Idisklib -o "${tproj}" $(find "${tproj}.tproj" -name '*.c') disklib/libdisk.a -framework IOKit -framework CoreFoundation -lutil
    arm-apple-darwin-strip "${tproj}"
done

cd fstyp.tproj
for c in *.c; do
    bin=../$(basename "${c}" .c)
    arm-apple-darwin-gcc -o "${bin}" "${c}"
    arm-apple-darwin-strip "${bin}"
done
cd ..

chmod u+s umount quota

pkg: mkdir -p /usr/bin /usr/libexec /usr/sbin /sbin

pkg: cp -a quota /usr/bin
pkg: cp -a vsdbutil repquota fdisk edquota quot quotaon /usr/sbin
pkg: cp -a vndevice /usr/libexec
pkg: cp -a clri dumpfs tunefs umount @(fsck|fstyp|mount|newfs)?(_*([a-z0-9])) /sbin
