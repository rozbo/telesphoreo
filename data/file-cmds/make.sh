pkg:extract
cd *
pkg: mkdir -p /usr/bin
for bin in chflags compress ipcrm ipcs pax; do
    arm-apple-darwin-gcc -o "${bin}/${bin}" "${bin}"/*.c -D'__FBSDID(x)=' -D__POSIX_C_SOURCE
    pkg: cp -a "${bin}/${bin}" /usr/bin
done
