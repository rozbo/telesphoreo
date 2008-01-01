shopt -s extglob
tar -zxvf "${PKG_DATA}/system_cmds-431.tar.gz"
cd system_cmds-431
mkdir -p "${PKG_DEST}/usr/bin"
cd getconf.tproj
for gperf in *.gperf; do
    LC_ALL=C awk -f fake-gperf.awk <"${gperf}" >"$(basename "${gperf}" .gperf).c"
done
cd ..
cp -va "${PKG_DATA}"/kextmanager* .
# dmesg reboot shutdown
for tproj in getconf getty hostinfo iostat login nvram passwd sync sysctl vipw zprint; do
    echo "${tproj}"
    arm-apple-darwin-gcc -o "${tproj}" "${tproj}.tproj"/!(od_passwd).c -I. -D'__FBSDID(x)=' -DTARGET_OS_EMBEDDED -framework CoreFoundation -framework IOKit kextmanagerUser.c
    cp -a "${tproj}" "${PKG_DEST}/usr/bin"
done
