tar -zxvf "${PKG_DATA}/basic_cmds-48.tar.gz"
cd basic_cmds-48
for bin in mesg write uudecode uuencode; do
    arm-apple-darwin-gcc -o "${bin}/${bin}" "${bin}"/*.c
    pkg:usrbin "${bin}/${bin}"
done
