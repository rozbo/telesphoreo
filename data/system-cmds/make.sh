shopt -s extglob
pkg:setup

cd getconf.tproj
for gperf in *.gperf; do
    LC_ALL=C awk -f fake-gperf.awk <"${gperf}" >"$(basename "${gperf}" .gperf).c"
done
cd ..

${PKG_TARG}-gcc -o passwd passwd.tproj/!(od_passwd).c -I. -DTARGET_OS_EMBEDDED
${PKG_TARG}-gcc -o dmesg dmesg.tproj/*.c -I.

cp -va "${PKG_DATA}"/kextmanager* .
# XXX: shutdown
for tproj in getconf getty hostinfo iostat login nvram reboot sync sysctl vipw zprint; do
    cflags=

    case ${tproj} in (shutdown)
        cflags="${cflags} -lbsm"
    ;; esac

    echo "${tproj}"
    ${PKG_TARG}-gcc -o "${tproj}" "${tproj}.tproj"/*.c -I. -D'__FBSDID(x)=' -DTARGET_OS_EMBEDDED -framework CoreFoundation -framework IOKit kextmanagerUser.c ${cflags}
done

chmod u+s passwd login

pkg: mkdir -p /bin /sbin /usr/bin /usr/sbin

pkg: cp -a sync /bin
pkg: cp -a reboot dmesg /sbin
pkg: ln -s reboot /sbin/halt
pkg: cp -a passwd zprint getty getconf hostinfo login /usr/bin
pkg: cp -a sysctl nvram vipw iostat /usr/sbin
