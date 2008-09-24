shopt -s extglob
pkg:setup

cd getconf.tproj
for gperf in *.gperf; do
    LC_ALL=C awk -f fake-gperf.awk <"${gperf}" >"$(basename "${gperf}" .gperf).c"
done
cd ..

${PKG_TARG}-gcc -o passwd passwd.tproj/!(od_passwd).c -I. -DTARGET_OS_EMBEDDED
# XXX: ${PKG_TARG}-gcc -o chpass chpass.tproj/*.c -I. -Ipwd_mkdb.tproj -Ivipw.tproj
${PKG_TARG}-gcc -o dmesg dmesg.tproj/*.c -I.
${PKG_TARG}-gcc -o arch arch.tproj/*.m -I. -framework CoreFoundation -framework Foundation -lobjc

cp -va "${PKG_DATA}"/kextmanager* .
# XXX: shutdown
for tproj in ac accton getconf getty hostinfo iostat login mkfile nvram reboot sync sysctl update vifs vipw zdump zic zprint; do
    cflags=

    case ${tproj} in (shutdown)
        cflags="${cflags} -lbsm"
    ;; esac

    echo "${tproj}"
    ${PKG_TARG}-gcc -o "${tproj}" "${tproj}.tproj"/*.c -I. -D'__FBSDID(x)=' -DTARGET_OS_EMBEDDED -framework CoreFoundation -framework IOKit kextmanagerUser.c ${cflags}
done

chmod u+s passwd login

pkg: mkdir -p /bin /sbin /usr/bin /usr/sbin

pkg: cp -a nologin.tproj/nologin.sh /sbin/nologin
pkg: cp -a pagesize.tproj/pagesize.sh /usr/bin/pagesize
pkg: chmod 755 /sbin/nologin /usr/bin/pagesize

pkg: cp -a sync /bin
pkg: cp -a reboot dmesg /sbin
pkg: ln -s reboot /sbin/halt
pkg: cp -a arch getconf getty hostinfo login passwd zprint /usr/bin
pkg: ln -s chpass /usr/bin/chfn
pkg: ln -s chpass /usr/bin/chsh
pkg: ln -s less /usr/bin/more
pkg: cp -a ac accton iostat mkfile nvram sysctl update vifs vipw zdump zic /usr/sbin
