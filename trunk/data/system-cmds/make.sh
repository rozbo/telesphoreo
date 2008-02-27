shopt -s extglob
pkg:extract
cd *
pkg:patch

cd getconf.tproj
for gperf in *.gperf; do
    LC_ALL=C awk -f fake-gperf.awk <"${gperf}" >"$(basename "${gperf}" .gperf).c"
done
cd ..

arm-apple-darwin-gcc -o passwd passwd.tproj/!(od_passwd).c -I. -DTARGET_OS_EMBEDDED
arm-apple-darwin-strip passwd

arm-apple-darwin-gcc -o dmesg dmesg.tproj/*.c -I.
arm-apple-darwin-strip dmesg

cp -va "${PKG_DATA}"/kextmanager* .
# XXX: shutdown
for tproj in getconf getty hostinfo iostat login nvram reboot sync sysctl vipw zprint; do
    cflags=

    case ${tproj} in (shutdown)
        cflags="${cflags} -lbsm"
    ;; esac

    echo "${tproj}"
    arm-apple-darwin-gcc -o "${tproj}" "${tproj}.tproj"/*.c -I. -D'__FBSDID(x)=' -DTARGET_OS_EMBEDDED -framework CoreFoundation -framework IOKit kextmanagerUser.c ${cflags}
    arm-apple-darwin-strip "${tproj}"
done

chmod u+s passwd login

pkg: mkdir -p /bin /sbin /usr/bin /usr/sbin

pkg: cp -a sync /bin
pkg: cp -a reboot dmesg /sbin
pkg: cp -a passwd zprint getty getconf hostinfo login /usr/bin
pkg: cp -a sysctl nvram vipw iostat /usr/sbin
