shopt -s extglob
pkg:setup

cd disklib
rm -f mntopts.h getmntopts.c
${PKG_TARG}-gcc -c *.c
${PKG_TARG}-ar -r libdisk.a *.o
cd ..

for tproj in !(fstyp|dev_mkdb|dump|fsck_hfs|fuser|mount_hfs|restore|quotacheck|ufs).tproj; do
    tproj=$(basename "${tproj}" .tproj)
    echo ${tproj}

    extra=
    if [[ ${tproj} = mount_cd9660 ]]; then
        extra="${extra} -framework IOKit"
    fi

    if [[ ${tproj} = mount_cd9660 || ${tproj} = newfs_hfs ]]; then
        extra="${extra} -framework CoreFoundation"
    fi

    ${PKG_TARG}-gcc -Idisklib -o "${tproj}" $(find "${tproj}.tproj" -name '*.c') disklib/libdisk.a -lutil ${extra}
done

cd fstyp.tproj
for c in *.c; do
    bin=../$(basename "${c}" .c)
    ${PKG_TARG}-gcc -o "${bin}" "${c}"
done
cd ..

chmod u+s umount quota

pkg: mkdir -p /usr/bin /usr/libexec /usr/sbin /sbin

pkg: cp -a quota /usr/bin
pkg: cp -a vsdbutil repquota fdisk edquota quot quotaon /usr/sbin
pkg: cp -a vndevice /usr/libexec
pkg: cp -a clri dumpfs tunefs umount @(fsck|fstyp|mount|newfs)?(_*([a-z0-9])) /sbin
