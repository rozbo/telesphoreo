pkg:extract
cd *
pkg: mkdir -p /usr/bin

arm-apple-darwin-gcc -o hexdump/hexdump hexdump/{conv,display,hexdump,hexsyntax,odsyntax,parse}.c -D'__FBSDID(x)='
pkg: cp -a hexdump/hexdump /usr/bin

for bin in ctags error rpcgen unifdef; do
    arm-apple-darwin-gcc -o "${bin}/${bin}" "${bin}"/*.c
    pkg: cp -a "${bin}/${bin}" /usr/bin
done