pkg:extract
cd *
pkg:patch
cp -a "${PKG_DATA}"/*.[ch] .
declare -a flags
# XXX: don't use this on darwin8
flags[${#flags[@]}]=-DNEED_PSELECT
"${PKG_TARG}-gcc" -fno-common !(dns_async).c -o libresolv.dylib -dynamiclib -I. -linfo -install_name /usr/lib/libresolv.dylib "${flags[@]}"
pkg: mkdir -p /usr/lib
pkg: cp -a libresolv.dylib /usr/lib
